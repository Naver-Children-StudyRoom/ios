//
//  TutorialView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/28.
//

import SwiftUI

struct TutorialView: View {
    let tutorialTopic: ServiceIntro?
    
    @State var isShow: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NavigationBarView(isShow: $isShow, title: "튜토리얼")
                    .frame(height: 54)
                Spacer()
                Text(tutorialTopic?.description ?? "")
                Spacer()
            }
            .frame(width: geometry.size.width)
        }
        .onAppear {
            debugLog("서비스 소개 화면 진입")
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(tutorialTopic: .studyExplore)
    }
}
