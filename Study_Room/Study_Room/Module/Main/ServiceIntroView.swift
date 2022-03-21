//
//  ServiceIntroView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/21.
//

import SwiftUI

struct ServiceIntroView: View {
    @Binding var showMenu: Bool
    var body: some View { // 테스트 코드
        Button {
            self.showMenu.toggle()
        } label: {
            Text("show Menu")
        }

    }
}

struct ServiceIntroView_Previews: PreviewProvider {
    @State static var showMenu: Bool = true
    static var previews: some View {
        ServiceIntroView(showMenu: $showMenu)
    }
}
