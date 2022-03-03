//
//  ContentView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/12.
//

import SwiftUI

/// 메인 화면으로 쓰자
struct MainView: View {
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
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
