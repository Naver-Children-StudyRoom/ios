//
//  ApiRequest.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/01/15.
//

import SwiftyJSON
import Alamofire

open class APIRequest {
    public static let shared = APIRequest()
    
    private var ongoingSessionManager: [String: Session] = [:]
    private let sessionManagerHandlingQueue = DispatchQueue(label: "SessionManagerHandlingQueue")
    
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
                completion?(.success(JSON(result)))
            } else {
                let error = response.parsedError
                recordError(response: response, method: method, queryParameters: queryParameters, requestParameters: requestParameters, error: error)
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
        let url = api.isValidUrlHeader ? api : UrlBuilder.createUrl(relativePath: api, parameters: queryParameters)
        debugLog("API Request :: url = \(url)")
        
        let sessionManager = Session.createInstance(retrier: retrier)
        let sessionManagerID = UUID().uuidString
        shared.add(sessionManager: sessionManager, id: sessionManagerID)
        
        let encoding: ParameterEncoding = URLEncoding.default
            
        let dataRequest = sessionManager.request(url, method: method, parameters: requestParameters, encoding: encoding, headers: headers).validate()
        return (dataRequest, sessionManagerID)
    }
}

// MARK:- 에러 처리

extension APIRequest {
    
    private class func recordError<T>(response: AFDataResponse<T>, method: HTTPMethod, queryParameters: Parameters? = nil, requestParameters: Parameters? = nil, error: Any? = nil) {
        // GP 이외의 API (ex. like) 는 result 구조가 달라서 에러로 분류될 수 있다. 이 경우에는 로그 남기지 않음.
        guard let url = response.request?.url?.absoluteString else { return }
        
        // 에러코드 -999 (취소됨) 은 이벤트 무시
        let errorCode = (error as? NSError)?.code
        guard errorCode != NSURLErrorCancelled else { return }
        
        var errorMessage: String?
        
        switch error {
        case is NSError: errorMessage = (error as? NSError)?.description
        case is Error: errorMessage = (error as? Error)?.localizedDescription
        default: break
        }
        
        let message = """
        \(url)
        method = \(method.rawValue)
        queryParameters = \(queryParameters?.description ?? "nil")
        requestParameters = \(requestParameters?.description ?? "nil")
        rawJson = \(response.getRawJson() ?? "nil")
        description = \(response.debugDescription)
        \(errorMessage ?? "no error message found")
        """
        
        apiLog(message, errorCode: errorCode)
    }
    
    /// SessionManager를 shared instance의 dictionary에 보관해둔다.
    /// 이렇게 해야 API response를 받을 때까지 SessionManager instance가 release되지 않고 유지됨.
    private func add(sessionManager: Session, id: String) {
        sessionManagerHandlingQueue.async { [weak self] in
            self?.ongoingSessionManager[id] = sessionManager
        }
    }
    
    /// 사용 완료한 SessionManager를 shared instance의 dictionary에서 제거한다.
    public func removeSessionManager(id: String) {
        sessionManagerHandlingQueue.async { [weak self] in
            self?.ongoingSessionManager[id] = nil
        }
    }
}

public extension DataResponse {
    
    /// response에서 에러값을 추출한다.
    ///
    /// 1. 서버 규칙에 따라 code, message로 이루어진 JSON을 parsing해서 NSError를 생성, 리턴하고
    /// 2. 1번을 실패할 경우 response.error를 리턴한다.
    var parsedNSError: NSError? {
        guard let failJson = try? JSON(data: self.data ?? Data()), let message = parsedErrorMessage else { return parsedError as NSError? }
        
        return NSError(domain: Bundle.main.bundleIdentifier! + ".error.server.response",
                       code: failJson["code"].int ?? self.response?.statusCode ?? 0,
                       userInfo: [NSLocalizedDescriptionKey: message])
    }
    
    /// 서버 응답은 성공이지만 에러 메세지가 내려오는 경우 에러를 추출한다.
    ///
    /// 1. 서버 규칙에 따라 code, message로 이루어진 JSON을 parsing해서 Error를 생성, 리턴하고
    /// 2. 1번을 실패할 경우 response.error를 리턴한다.
    var parsedError: Error {
        if response?.statusCode == 401 {
            return CommonError.unauthorized
        } else if isOfflineError {
            return CommonError.offline
        } else {
            guard let message = parsedErrorMessage else { return error?.asAFError?.underlyingError ?? error ?? CommonError.failedToFetch }
            return CommonError.custom(message)
        }
    }
    
    /// response에서 에러값을 추출해서 message를 리턴한다.
    var parsedErrorMessage: String? {
        let messageFields = ["message", "errorMessage", "error"]
        guard let failJson = try? JSON(data: self.data ?? Data()) else { return nil }
        return messageFields.compactMap({ failJson[$0].string }).first(where: { !$0.isEmpty })
    }
    
    private var isOfflineError: Bool {
        return error?.asAFError?.original?.code.isOfflineErrorCode == true
            || error?.asAFError?.retry?.code.isOfflineErrorCode == true
            || response?.statusCode.isOfflineErrorCode == true
    }
}

fileprivate extension AFError {
    
    var original: Error? { return errorTuple?.1 }
    var retry: Error? { return errorTuple?.0 }
    
    private var errorTuple: (Error, Error)? {
        switch self {
        case .requestRetryFailed(retryError: let retry, originalError: let original):
            return (retry, original)
            
        default: return nil
        }
    }
}
