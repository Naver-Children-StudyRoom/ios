//
//  SignUpViewModel.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/06/06.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var userEmail: String = "" {
        didSet {
            guard oldValue != userEmail else { return }
            startValidEmailTimer()
        }
    }
    @Published var userPassword: String = ""
    @Published var profileImage: String = "" // TODO: 향후 multipart 업로드 진행 예정
    @Published var userName: String = ""
    @Published var signupButtonAvailable: Bool = false
    @Published var isToastShow: Bool = false
    @Published var isVerifyEmailView: Bool = false
    @Published var confirmKey: String = ""
    
    // Timer
    var validEmailTimer: Timer?
    
    private var networkModel = SignUpNetworkModel()
    
    var errorMessage: Error?
    
    deinit {
        stopValidEmailTimer()
    }
    
    func requestSignUpUser(completion: @escaping ((UserModel) -> Void)) {
        
        networkModel.requestSignUpUser(userEmail: userEmail, userPassword: userPassword, userName: userName, completion: { result in
            switch result {
            case .success(let userModel):
                completion(userModel)
            case .failure(let error):
                debugLog("회원가입 실패 error: \(error)")
                completion(UserModel())
            }
        })
    }
    
    func requestValidEmail() {
        stopValidEmailTimer()
        
        networkModel.validEmailCheck(email: userEmail, completion: { [weak self] result in
            switch result {
            case .success(let value):
                self?.isVerifyEmailView = value
            case .failure(let error):
                debugLog("\(error)")
                self?.errorMessage = error
                self?.isToastShow = true
                self?.isVerifyEmailView = false
            }
        })
    }
    
    func requestVerifyEmail() {
        
        networkModel.verifyEmailCheck(email: userEmail, confirmKey: confirmKey, completion: { [weak self] result in
            switch result {
            case .success:
                self?.signupButtonAvailable = true
                return
            case .failure(let error):
                debugLog("\(error)")
                self?.errorMessage = error
                self?.isToastShow = true
            }
            
        })
    }
}

// MARK: - Timer
extension SignUpViewModel {
    private var timerDelay: Double { return 1.0 }
    
    // 상품명 텍스트를 입력하면 약간의 딜레이 후 fetchProduct API 호출
    private func startValidEmailTimer() {
        stopValidEmailTimer()
        
        validEmailTimer = Timer.scheduledTimer(withTimeInterval: timerDelay, repeats: false, block: { [weak self] _ in
            self?.requestValidEmail()
        })
    }
    
    private func stopValidEmailTimer() {
        validEmailTimer?.invalidate()
        validEmailTimer = nil
    }
}
