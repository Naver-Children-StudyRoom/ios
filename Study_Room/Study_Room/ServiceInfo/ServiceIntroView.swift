//
//  ServiceIntroView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/21.
//

import SwiftUI

struct ServiceIntroView: View {
    @Binding var loginCheck: Bool
    var body: some View { // 테스트 코드
        if loginCheck {
            TabView {
                ServiceIntroDetailView()
                    .tabItem {
                        Label("서비스 소개", systemImage: "1.square.fill")
                    }
                ServiceIntroDetailView()
                    .tabItem {
                        Label("독서실 둘러보기", systemImage: "1.square.fill")
                    }
                ServiceIntroDetailView()
                    .tabItem {
                        Label("마이 플래너", systemImage: "1.square.fill")
                    }
                ServiceIntroDetailView()
                    .tabItem {
                        Label("마이페이지", systemImage: "1.square.fill")
                    }
            }
//            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        } else {
            ServiceIntroDetailView()
        }
    }
}

struct ServiceIntroView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceIntroView(loginCheck: .constant(true))
    }
}
