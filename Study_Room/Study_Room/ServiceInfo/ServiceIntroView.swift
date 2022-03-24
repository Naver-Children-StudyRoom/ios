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
        ScrollView {
            ServiceIntroDetailView()
            ServiceIntroDetailView()
            ServiceIntroDetailView()
        }
    }
}

struct ServiceIntroView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceIntroView(loginCheck: .constant(true))
    }
}
