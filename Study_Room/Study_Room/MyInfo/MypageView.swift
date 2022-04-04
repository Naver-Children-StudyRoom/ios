//
//  MypageView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/04/04.
//

import SwiftUI

struct MypageView: View {
    var body: some View {
        VStack {
            Text("마이페이지View")
            Button {
                debugLog("로그아웃")
            } label: {
                Text("로그아웃")
            }
        }
    }
}

struct MypageView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView()
    }
}
