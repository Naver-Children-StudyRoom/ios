//
//  SignUpViewModel.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/06/06.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    @Published var profileImage: String = "" // TODO: 향후 multipart 업로드 진행 예정
    @Published var userName: String = ""
    
    private var networkModel = SignUpNetworkModel()
    
    func requestSignUpUser(completion: @escaping ((UserModel) -> Void)) {
        networkModel.requestSignUpUser(userEmail: userEmail, userPassword: userPassword, userName: userName, completion: { result in
            switch result {
            case .success(let userModel):
                completion(userModel)
            case .failure(let error):
                debugLog("회원가입 실패 error: \(error)")
            }
        })
    }
}
