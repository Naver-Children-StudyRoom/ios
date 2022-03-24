//
//  ContentView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/12.
//

import SwiftUI

/// 메인 화면으로 쓰자
struct MainView: View {
    @StateObject private var userManager: UserManager = UserManager()
    @StateObject private var viewModel: MainViewModel = MainViewModel()
    
    // MARK: - HIDE TAB BAR
    init() {
        UITabBar.appearance().isHidden = false
    }
    
    var body: some View {
        GeometryReader { geometry in
            if userManager.loginCheck ?? true {
                TabView(selection: $viewModel.currentTab) {
                    ServiceIntroDetailView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .tag(Tab.ServiceInfo)
                    ServiceIntroDetailView()
                        .tag(Tab.StudyExplore)
                    ServiceIntroDetailView()
                        .tag(Tab.Planner)
                    Text("sdf")
                        .tag(Tab.Mypage)
                }
                .overlay(
                    // MARK: - CUSTOM TAB BAR
                    HStack(spacing: 0) {
                        // MARK: - TAB BUTTON
                        TabButton(Tab: .ServiceInfo)
                        TabButton(Tab: .StudyExplore)
//                            .offset(x: -10)
                        
                        // MARK: CURVED BUTTON
//                        Button {
//
//                        } label: {
//                            Image("cart")
//                                .resizable()
//                                .renderingMode(.template)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 26, height: 26)
//                                .offset(x: -1)
//                                .padding(18)
//                                .foregroundColor(Color.white)
//                                .background(Color("Btnbg"))
//                                .clipShape(Circle())
//                            //MAR: - BUTTON SHADOWS
//                                .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
//                                .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
//                        }
//                        .offset(y: -30)
                        
                        TabButton(Tab: .Planner)
//                            .offset(x: 10)
                        TabButton(Tab: .Mypage)
                    }
                        .padding(.top, 20)
                    .background(
                        Color.white
                            //.clipShape(CustomCurveShape())
                            //MARK: - SHADOW
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                            .ignoresSafeArea(.container, edges: .bottom)
                    )
                    //MARK: - HIDE TAB ON DETAIL VIEW
                    //.offset(y: viewModel.showDetail ? 200 : 0)
                    , alignment: .bottom
                )
            } else {
                ServiceIntroDetailView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    @ViewBuilder
    func TabButton(Tab: Tab)-> some View {
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
    static var previews: some View {
        MainView()
    }
}
