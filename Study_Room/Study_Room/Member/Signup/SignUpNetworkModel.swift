//
//  SignUpNetworkModel.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/06/06.
//

import Foundation

class SignUpNetworkModel {
    func requestSignUpUser(userEmail: String, userPassword: String, userName: String, completion: @escaping ((Result<UserModel, Error>) -> Void)) {
        validEmailCheck(email: userEmail, completion: { result in
            switch result {
            case .success(let emailReceiveYn):
                
                debugLog("이메일 중복 여부 : \(emailReceiveYn)")
                let api = "signup"
                
                let param: [String: Any] = [
                    "email": userEmail,
                    "password": userPassword,
                    "name": userName,
                    "emailReceiveYn" : emailReceiveYn
                ]
                
                APIRequest.requestJSON(api: api, method: .post, requestParameters: param, completion: { result in
                    switch result {
                    case .success(let json):
                        guard let userModel = UserModel(json: json) else { completion(.failure(CommonError.failedToFetch)); return }
                        completion(.success(userModel))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
                
                return
            case .failure(let error):
                debugLog("이메일 중복 체크 api 에러 \(error)")
                completion(.failure(error))
            }
        })
    }
    
    func validEmailCheck(email: String, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        let api = "valid-email"
        
        let param: [String: Any] = [
            "email": email
        ]
        
        APIRequest.requestJSON(api: api, parameters: param, completion: { result in
            switch result {
            case .success(let value):
                completion(.success(value["value"].bool ?? false))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
