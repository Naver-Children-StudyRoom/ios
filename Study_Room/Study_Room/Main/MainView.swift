//
//  ContentView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/12.
//

import SwiftUI

/// 메인 화면으로 쓰자
struct MainView: View {
    @StateObject private var viewModel: UserManager = UserManager()
    
    var body: some View {
        GeometryReader { geometry in
            if viewModel.loginCheck ?? true {
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
//                            .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            } else {
                ServiceIntroDetailView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
