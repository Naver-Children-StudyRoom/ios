//
//  ContentView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/12.
//

import SwiftUI

/// 메인 화면으로 쓰자
struct MainView: View {
    @State var loginCheck: Bool = false // 로그인되있는지 여부 체크하고 로그인되있으면 로그인메인화면 아니면 비로그인메인화면
    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.loginCheck = false
                    }
                }
            }
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    ServiceIntroView(showMenu: $loginCheck)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.loginCheck ? geometry.size.width / 2 : 0)
                        .disabled(self.loginCheck ? true : false)
                    if self.loginCheck {
                        HStack(spacing: 0.0) {
                            MenuView()
                                .frame(width: geometry.size.width / 2)
                                .transition(.move(edge: .leading))

                            Button {
                                withAnimation {
                                    self.loginCheck.toggle()
                                }
                            } label: {
                                Text("")
                                    .padding()
                                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                            }
                        }
                    }
                }
                .gesture(drag)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        debugLog("config 정보 로드할 부분")
                    })
                }
            }
            .navigationBarTitle("Main View", displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.loginCheck.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
