//
//  NavigationBarView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/28.
//

import SwiftUI

/// 공통으로 사용하게 될 네비게이션 Bar base View -> 향후엔 이미지좀 바꿔두자
struct NavigationBarView: View {
    @Environment(\.presentationMode) var presentationMode
    
    /// 헤더 타이틀
    var title: String
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                withAnimation {
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Image("iconHeaderBackB")
                    .frame(maxHeight: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0.0, leading: 13.0, bottom: 2.0, trailing: 16.0))
            })
            Spacer()
            Text(title)
                .kerning(0.0)
                .offset(x: -20) // TODO: 나중에 가운데 정렬 할수있을만한 방법 있나 확인해보기 
                .foregroundColor(Color.black)
                .font(.custom("AppleSDGothicNeo-SemiBold", size: 18))
            Spacer()
        }
        .modifier(NavigationViewModifier())
    }
}

struct NavigationViewModifier: ViewModifier {
    private let height: CGFloat = 54.0
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: height, alignment: .leading)
            .overlay(Rectangle()
                        .frame(width: nil, height: 1, alignment: .bottom)
                        .foregroundColor(Color.black.opacity(0.07)),
                     alignment: .bottom)
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    @Environment(\.presentationMode) static var presentationMode: Binding<PresentationMode>
    
    static var previews: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                NavigationBarView(title: "알림")
            }
            .frame(width: proxy.size.width, alignment: .leading)
        }
        .previewLayout(.fixed(width: 375.0, height: 54.0))
    }
}