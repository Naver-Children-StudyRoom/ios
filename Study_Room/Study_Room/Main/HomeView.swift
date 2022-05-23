//
//  HomeView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/05/13.
//

import SwiftUI

struct HomeView: View {
    @State private var isLoginView = false
    
    var body: some View {
        Button(action: {
            isLoginView.toggle()
        }, label: {
            Text("테스트로 로그인 화면 진입")
        })
        .fullScreenCover(isPresented: $isLoginView, content: LoginView.init) 
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
