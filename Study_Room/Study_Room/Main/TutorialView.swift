//
//  TutorialView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/28.
//

import SwiftUI

struct TutorialView: View {
    let tutorialTopic: ServiceIntro?
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NavigationBarView(title: "튜토리얼")
                Spacer()
                Text(tutorialTopic?.description ?? "")
                Spacer()
            }
            .frame(width: geometry.size.width)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(tutorialTopic: .studyExplore)
    }
}
