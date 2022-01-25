//
//  ApiRequest.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/01/15.
//

import SwiftyJSON
import Alamofire

open class ApiRequest {
    public static let shared = ApiRequest()
    
    /// JSON response를 받는 API Request
    /// - Parameters:
    ///   - api: 사용할 API. relative path만 전달하는 경우는 `UrlBuilder`에서 api gateway 주소와 조합해서 full url을 생성합니다. (ex : "members/{memberId}/documents")
    ///   - apiType: `APIGatewayType`에서 해당되는 타입을 선택한다. 기본값은 `live`
    ///   - method: `HTTPMethod`. 기본값은 `get`
    ///   - parameters: API URL에 추가하는 query parameter dictionary
    ///   - requestParameters: HTTP Request body에 추가하는 parameter dictionary
    ///   - customParameters: HTTP Request body에 추가하지만 dictionary가 아닌 String이나 Array 타입의 파라미터. 일반적으로 잘 사용하지 않는다.
    ///   - headers: 헤더
    ///   - queue: completion handler가 호출될 Queue
    ///   - retrier: API 실패시 재시도 처리를 해주는 `RequestRetryHandler`
    ///   - success: 성공 클로저
    ///   - failure: 실패 클로저
    /// - Returns: `DataRequest`
    @discardableResult
    open class func requestJSON(
        api: String,
        method: HTTPMethod = .get,
        parameters queryParameters: Parameters? = nil,
        requestParameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        queue: DispatchQueue? = nil,
        retrier: RequestInterceptor? = nil,
        success: ((JSON) -> Void)? = nil,
        failure: ((NSError?) -> Void)? = nil) -> DataRequest {
        return requestJSON(api: api, method: method, parameters: queryParameters, requestParameters: requestParameters, headers: headers, queue: queue, retrier: retrier, completion: { result in
            switch result {
            case .success(let json): success?(json)
            case .failure(let error): failure?(error as NSError)
            }
        })
    }
    
    /// JSON response를 받는 API Request
    /// - Parameters:
    ///   - api: 사용할 API. relative path만 전달하는 경우는 `UrlBuilder`에서 api gateway 주소와 조합해서 full url을 생성합니다. (ex : "members/{memberId}/documents")
    ///   - apiType: `APIGatewayType`에서 해당되는 타입을 선택한다. 기본값은 `live`
    ///   - method: `HTTPMethod`. 기본값은 `get`
    ///   - parameters: API URL에 추가하는 query parameter dictionary
    ///   - requestParameters: HTTP Request body에 추가하는 parameter dictionary
    ///   - customParameters: HTTP Request body에 추가하지만 dictionary가 아닌 String이나 Array 타입의 파라미터. 일반적으로 잘 사용하지 않는다.
    ///   - headers: 헤더
    ///   - queue: completion handler가 호출될 Queue
    ///   - retrier: API 실패시 재시도 처리를 해주는 `RequestRetryHandler`
    ///   - completion: completion closure
    /// - Returns: `DataRequest`
    @discardableResult
    open class func requestJSON(
        api: String,
        method: HTTPMethod = .get,
        parameters queryParameters: Parameters? = nil,
        requestParameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        queue: DispatchQueue? = nil,
        retrier: RequestInterceptor? = nil,
        completion: ((Result<JSON, Error>) -> Void)?) -> DataRequest {
        let (dataRequest, sessionManagerID) = request(api: api, method: method, parameters: queryParameters, requestParameters: requestParameters, headers: headers, queue: queue, retrier: retrier)
        
        dataRequest.responseJSON(queue: queue ?? .main) { (response: AFDataResponse<Any>) -> Void in
            if let result = response.value, response.error == nil {
                Dependency.record(apiType: apiType.rawValue, api: api, method: method.rawValue)
                completion?(.success(JSON(result)))
            } else {
                let error = response.parsedError
                shared.tryLoginClosure?(api, error)
                recordError(response: response, method: method, queryParameters: queryParameters, requestParameters: requestParameters, error: error)
                
                Dependency.record(apiType: apiType.rawValue, api: api, method: method.rawValue, error: error)
                completion?(.failure(error))
            }
            
            shared.removeSessionManager(id: sessionManagerID)
        }
        
        return dataRequest
    }
    
    /// Alamofire DataRequest 생성
    ///
    /// - Parameters:
    ///   - api: 사용할 API. relative path만 전달하는 경우는 `UrlBuilder`에서 api gateway 주소와 조합해서 full url을 생성합니다. (ex : "members/{memberId}/documents")
    ///   - apiType: `APIGatewayType`에서 해당되는 타입을 선택한다. 기본값은 `live`
    ///   - method: `HTTPMethod`. 기본값은 `get`
    ///   - parameters: API URL에 추가하는 query parameter dictionary
    ///   - requestParameters: API Request body에 추가하는 parameter dictionary
    ///   - customParameters: dictionary가 아닌 String이나 Array 타입의 파라미터. 일반적으로 잘 사용하지 않는다.
    ///   - headers: 헤더
    ///   - queue: completion handler가 호출될 Queue
    ///   - retrier: API 실패시 재시도 처리를 해주는 `RequestRetryHandler`
    open class func request(
        api: String,
        method: HTTPMethod = .get,
        parameters queryParameters: Parameters? = nil,
        requestParameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        queue: DispatchQueue? = nil,
        retrier: RequestInterceptor? = nil) -> (DataRequest, String) {
        let url = api.isValidUrlHeader ? api : UrlBuilder.createUrl(relativePath: api, apiType: apiType, parameters: queryParameters)
        debugLog("API Request :: url = \(url)")
        
        let sessionManager = Session.createInstance(retrier: retrier)
        let sessionManagerID = UUID().uuidString
        shared.add(sessionManager: sessionManager, id: sessionManagerID)
        
        let encoding: ParameterEncoding = {
            guard let encoding = customParameters?.encoding else { return requestParameters == nil ? URLEncoding.default : JSONEncoding.default }
            return encoding
        }()
        let dataRequest = sessionManager.request(url, method: method, parameters: requestParameters ?? customParameters?.asParameters, encoding: encoding, headers: createHeaders(with: headers, apiType: apiType)).validate()
        return (dataRequest, sessionManagerID)
    }
}
