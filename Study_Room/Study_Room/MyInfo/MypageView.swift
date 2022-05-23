//
//  MypageView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/04/04.
//

import SwiftUI

struct MypageView: View {
    @EnvironmentObject var currentUser: UserModel
    
    var body: some View {
        VStack {
            Text("마이페이지View")
            Button { // progressBar같은거 하나 만들어서 이게 클릭되면 0.5초에서 1초뒤에 화면 새로고침 되도록 해도 될듯? 어처피 값들이 다 연결되있어서
                debugLog("로그아웃")
                currentUser.isLogin = false
                UserDefaults.standard.set(false, forKey: "isLogin")
            } label: {
                Text("로그아웃")
            }
        }
    }
}

struct MypageView_Previews: PreviewProvider {
    @StateObject static var currentUser: UserModel = UserModel()
    static var previews: some View {
        MypageView()
            .environmentObject(currentUser)
    }
}
