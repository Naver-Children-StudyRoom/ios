//
//  LoginManager.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/04/30.
//

import Foundation

class LoginViewModel: ObservableObject {
    public var userModel: UserModel?
    
    @Published var loginCheck: Bool? // UserDefault로 처음 실행 떄 확인할 거라서 이건 어떻게 될진 모르겠다.

    public func requestLoginUser(completion: @escaping ((Result<UserModel, Error>) -> Void)) {
        // 여기서 로그인 api호출을 진행할 거고
        // UserDefault or AppStorage -> Maybe Appstorage
    }
}
