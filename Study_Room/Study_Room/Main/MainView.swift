//
//  ContentView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/12.
//

import SwiftUI

/// 메인 화면으로 쓰자
struct MainView: View {
    @ObservedObject private var viewModel: MainViewModel = MainViewModel()
    @ObservedObject private var loginViewModel: LoginViewModel = LoginViewModel()
    
    @EnvironmentObject var currentUser: UserModel
    
    // MARK: - HIDE TAB BAR
    init() {
        UITabBar.appearance().isHidden = false
    }
    
    var body: some View {
        GeometryReader { geometry in
            if !currentUser.loginCheck() { // 일단 테스트 용도로 false 로 설정
                VStack {
                    MainTabView()
                        .frame(maxHeight: geometry.size.height)
                        .frame(width: geometry.size.width)
                    HStack(spacing: 0) {
                        // MARK: - TAB BUTTON
                        TabButton(Tab: .StudyExplore)
                        TabButton(Tab: .ServiceInfo)
                        TabButton(Tab: .Home)
                        TabButton(Tab: .Planner)
                        TabButton(Tab: .Mypage)
                    }
                    .padding(EdgeInsets.init(top: 20, leading: 0.0, bottom: 34, trailing: 0.0))
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.bottom)
                    .background(
                        Color.white
                            .ignoresSafeArea(.container, edges: .bottom)
                    )
                }
                .frame(width: geometry.size.width, height: geometry.size.height + geometry.safeAreaInsets.bottom)
            } else {
                ServiceIntroView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

// MARK: - func
extension MainView {
    @ViewBuilder
    func TabButton(Tab: Tab) -> some View {
        Button {
            withAnimation {
                viewModel.currentTab = Tab
            }
        } label: {
            Image(Tab.rawValue)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(viewModel.currentTab == Tab ? Color("Btnbg") : Color.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    func MainTabView() -> some View {
        switch viewModel.currentTab {
        case .StudyExplore:
            StudyRoomExploreView() // 독서실 둘러보기
        case .ServiceInfo:
            ServiceIntroView() // 서비스 소개
                .environmentObject(currentUser)
        case .Home:
            HomeView() // TODO: 나중에 로그인 했을 때 처음에 나의 독서실 요약, 추천독서실, 마이플래너 미리보기가 구현된 View를 출력할 예정
        case .Planner:
            MyPlannerView() // 마이플래너
        case .Mypage:
            MypageView() // 마이페이지
        }
    }
}

struct CustomCurveShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            // MARK: = CURVE CENTER
            let mid = rect.width / 2
            
            path.move(to: CGPoint(x: mid - 70, y: 0))
            
            let to1 = CGPoint(x: mid, y: 45)
            let control1 = CGPoint(x: mid - 35, y: 0)
            let control2 = CGPoint(x: mid - 35, y: 45)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            let to2 = CGPoint(x: mid + 70, y: 0)
            let control3 = CGPoint(x: mid + 35, y: 45)
            let control4 = CGPoint(x: mid + 35, y: 0)
            
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    @StateObject static var currentUser: UserModel = UserModel()
    static var previews: some View {
        MainView()
            .environmentObject(currentUser)
    }
}
