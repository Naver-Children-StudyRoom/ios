//
//  ServiceIntroDetailView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/21.
//

import SwiftUI

struct ServiceIntroDetailView: View {
    var body: some View {
        HStack {
            Image(systemName: "star")
            Text("Service Info")
            Button {
                debugLog("서비스 소개로 이동")
            } label: {
                Image(systemName: "calendar")
            }
        }
    }
}

struct ServiceIntroDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceIntroDetailView()
    }
}
