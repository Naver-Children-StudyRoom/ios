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

    private let networkModel = LoginNetworkModel()
    
    func fetchLoginUser(completion: @escaping (() -> Void)) {
        networkModel.requestLoginUser(completion: { result in
            switch result {
            case .success(let user):
                self.userModel = user
                completion()
            case .failure(let error):
                debugLog("로그인 실패 : \(error.localizedDescription)")
                return
            }
            completion()
        })
    }
    
}
