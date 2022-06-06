//
//  SignupView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/06/02.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel: SignUpViewModel = SignUpViewModel()
    var body: some View {
        VStack {
            NavigationBarView(isShow: .constant(false), title: "회원가입")
                .frame(height: 54)
                .frame(maxWidth: .infinity)
            Spacer()
            HStack {
                Text("Email : ")
                TextField("Email", text: $viewModel.userEmail)
                    .frame(width: 100.0, height: 10.0)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
            HStack {
                Text("Password : ")
                TextField("Password", text: $viewModel.userPassword)
                    .frame(width: 100.0, height: 10.0)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
            HStack {
                Text("name : ")
                TextField("name", text: $viewModel.userName)
                    .frame(width: 100.0, height: 10.0)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
            Button {
                viewModel.requestSignUpUser()
                debugLog("회원가입")
            } label: {
                Text("회원가입")
            }

            Spacer()
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
