//
//  ContentView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/12.
//

import SwiftUI

/// 메인 화면으로 쓰자
struct MainView: View {
    var loginCheck: Bool = false // 로그인되있는지 여부 체크하고 로그인되있으면 로그인메인화면 아니면 비로그인메인화면 
    var body: some View {
        VStack {
            NavigationView {
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                }
            }
            Text("Hello, world!")
                .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                debugLog("config 정보 로드할 부분")
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
