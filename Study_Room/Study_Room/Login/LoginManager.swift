//
//  LoginManager.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/04/30.
//

import Foundation

class LoginManager: ObservableObject {
    public var userModel: UserModel?
    
    @Published var loginCheck: Bool?

    public func requestLoginUser(completion: @escaping ((Result<UserModel, Error>) -> Void)) {
        // 여기서 로그인 api호출을 진행할 거고
    }
}
