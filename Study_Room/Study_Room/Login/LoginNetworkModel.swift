//
//  LoginNetworkModel.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/05/03.
//

import Foundation
import SwiftyJSON

class LoginNetworkModel {
    func requestLoginUser(completion: @escaping ((Result<UserModel, Error>) -> Void)) {
        let api = "login"
        
        APIRequest.requestJSON(api: api, method: .get, completion: { result in
            if let json = result.success, let user = UserModel(json: json) {
                completion(.success(user))
            } else {
                completion(.failure(result.error ?? CommonError.failedToFetch))
            }
        })
    }
}
