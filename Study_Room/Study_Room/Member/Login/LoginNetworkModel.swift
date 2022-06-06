//
//  LoginNetworkModel.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/05/03.
//

import Foundation
import SwiftyJSON
import Alamofire

class LoginNetworkModel {
    func requestLoginUser(userEmail: String, userPassword: String, completion: @escaping ((Result<UserModel, Error>) -> Void)) {
        let api = "login"
        
        let param: [String: Any] = [
            "email": userEmail,
            "password": userPassword
        ]
        
        let request = APIRequest.request(api: api, method: .post, requestParameters: param).0
        
        request.response(completionHandler: { [weak self] response in
            guard let accessToken = self?.fetchUserInfo(from: response), let data = response.value, response.error == nil else {
                let error = response.parsedError
                debugLog("Api Error: \(error)")
                completion(.failure(error))
                return
            }
            
            debugLog("로그인에 성공하였습니다. 현재 로그인한 유저의 accessToken값은 다음과 같습니다: \(accessToken)")
            let json = JSON(data ?? Data())
            let user = UserModel(json: json)
            self?.setCurrentUserInfo(json: json, accessToken: accessToken)
            completion(.success(user ?? UserModel()))
        })
    }
    
    private func fetchUserInfo(from response: AFDataResponse<Data?>) -> String? {
        guard let accessToken = response.response?.allHeaderFields["Authorization"] as? String, !accessToken.isBlank else {
            warningLog("로그인 API에서 토큰 획득 실패.\n\(response)")
            return nil
        }
        return accessToken
    }
    
    func setCurrentUserInfo(json: JSON, accessToken: String) {
        guard let email = json["email"].string,
              let nickname = json["nickname"].string,
              let profileImageUri = json["profileImageUri"].string else { return }
        
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(nickname, forKey: "nickname")
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(profileImageUri, forKey: "profileImageUri")
        UserDefaults.standard.set(true, forKey: "isLogin")
    }
}
