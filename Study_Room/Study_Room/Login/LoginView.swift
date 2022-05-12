//
//  LoginView.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/01/22.
//

import SwiftUI
import NaverThirdPartyLogin
import UIKit
import RxSwift

struct LoginView: View {
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    @State private var isOn = true
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            NavigationBarView(title: "로그인")
                .frame(height: 54)
                .frame(maxWidth: .infinity)
            Spacer()
            HStack {
                Image(systemName: "envelope")
                    .frame(width: 50.0, height: 50.0)
                TextField("ID / Email", text: $userEmail)
                    .frame(width: 100.0, height: 10.0)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
            HStack {
                Image(systemName: "lock").frame(width: 50.0, height: 50.0)
                SecureField("Password", text: $userPassword)
                    .frame(width: 100.0, height: 10.0)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
            
            loginAction()
            loginAccountManager()
        }
    }
}

extension LoginView {
    @ViewBuilder func loginAction() -> some View {
        HStack {
            Toggle(isOn: $isOn) {
                Text("자동")
            }
            .frame(width: 90, height: 80)
            
            Button(action: {
                viewModel.fetchLoginUser {
                    presentationMode.wrappedValue.dismiss()
                }
            }) { // api 호출
                Text("로그인")
                    .frame(width: 80, height: 10)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
        }.padding(EdgeInsets.init())
    }
    
    @ViewBuilder func loginAccountManager() -> some View {
        HStack(spacing: 20) {
            Button(action: {}) {
                Text("아이디/비밀번호 찾기")
            }
            Button(action: {}) {
                Text("회원가입")
            }
        }
        .frame(maxHeight: 250, alignment: .bottom)
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
