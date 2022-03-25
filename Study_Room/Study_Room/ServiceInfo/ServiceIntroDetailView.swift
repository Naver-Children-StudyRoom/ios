//
//  ServiceIntroDetailView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/21.
//

import SwiftUI

struct ServiceIntroDetailView: View {
    let model: ServiceIntroModel?
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
                        debugLog("서비스 소개로 이동")
                    } label: {
                        Text("자세히 알아보기")
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
