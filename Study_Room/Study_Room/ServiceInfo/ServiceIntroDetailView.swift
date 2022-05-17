//
//  ServiceIntroDetailView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/21.
//

import SwiftUI

struct ServiceIntroDetailView: View {
    let model: ServiceIntroModel?
    @State private var isPresented = false
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Image(model?.serviceIntro.imageName ?? "")
                    .resizable()
                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                
                VStack {
                    Text(model?.serviceIntro.description ?? "")
                        .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text(model?.buttonTitle ?? "")
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 5)
                            )
                    }
                    .visibility(model?.btnVisible ?? true)
                    .fullScreenCover(isPresented: $isPresented) {
                        if model?.serviceIntro == .login {
                            withAnimation {
                                LoginView()
                            }
                        } else {
                            withAnimation {
                                TutorialView(tutorialTopic: model?.serviceIntro)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ServiceIntroDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceIntroDetailView(
            model: ServiceIntroModel(
                btnVisible: true,
                serviceIntro: .studyExplore
            )
        )
    }
}
