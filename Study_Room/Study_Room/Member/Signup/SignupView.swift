//
//  SignupView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/06/02.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var currentUser: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: SignUpViewModel = SignUpViewModel()
    var body: some View {
        VStack {
            NavigationBarView(isShow: .constant(false), title: "회원가입")
                .frame(height: 54)
                .frame(maxWidth: .infinity)
            Spacer()
            VStack(spacing: 10) {
                HStack {
                    Text("Email : ")
                    Spacer()
                    TextField("Email", text: $viewModel.userEmail)
                        .frame(width: 100.0, height: 10.0)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                }
                .frame(width: 250)
                if !viewModel.isVerifyEmailView, !viewModel.userEmail.isBlank {
                    Text("올바른 이메일 형식이 아닙니다. ")
                        .foregroundColor(.red)
                }
                
                if viewModel.isVerifyEmailView {
                    HStack {
                        Spacer()
                        Text("인증번호 : ")
                        TextField("인증번호 입력", text: $viewModel.confirmKey)
                            .frame(width: 100.0, height: 10.0)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                        Button {
                            viewModel.requestVerifyEmail()
                        } label: {
                            Text("인증번호 확인")
                        }
                        Spacer()
                    }
                    .frame(width: 350)
                }
                HStack {
                    Text("Password : ")
                    Spacer()
                    TextField("Password", text: $viewModel.userPassword)
                        .frame(width: 100.0, height: 10.0)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                }
                .frame(width: 250)
                HStack {
                    Text("name : ")
                    Spacer()
                    TextField("name", text: $viewModel.userName)
                        .frame(width: 100.0, height: 10.0)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                }
                .frame(width: 250)
                
                if viewModel.signupButtonAvailable {
                    Button {
                        viewModel.requestSignUpUser(completion: { userModel in
                            currentUser.setInfo(model: userModel)
                            debugLog("회원가입 성공")
                            presentationMode.wrappedValue.dismiss()
                        })
                        debugLog("회원가입 실패")
                    } label: {
                        Text("회원가입")
                    }
                }
            }
            Spacer()
        }
        .toast(message: viewModel.errorMessage?.localizedDescription ?? CommonError.failedToApply.localizedDescription, isShowing: $viewModel.isToastShow)
    }
}

struct SignupView_Previews: PreviewProvider {
    @StateObject static var model: UserModel = UserModel()
    static var previews: some View {
        SignupView()
            .environmentObject(model)
    }
}
