//
//  LoginView.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/01/22.
//

import SwiftUI
import NaverThirdPartyLogin
import UIKit

struct LoginView: View {
    @State private var ID: String = ""
    @State private var PW: String = ""
    
    var body: some View {
        HStack {
            Text("로그인 화면")
                .padding()
            
            Button("로그인", action: {
                debugLog("test")
            })
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
