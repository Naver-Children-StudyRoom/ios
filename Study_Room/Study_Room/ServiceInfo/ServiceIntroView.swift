//
//  ServiceIntroView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/21.
//

import SwiftUI

struct ServiceIntroView: View {
    @ObservedObject private var viewModel: ServiceIntroViewModel = ServiceIntroViewModel()
    
    @EnvironmentObject var currentUser: UserModel // 이걸 활용해서 로그인 여부를 판단할 것인지, 그게 아니라면 UserDefault를 viewmodel에서 접근해서 사용할지, 고민이 좀 필요해보임
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ForEach(viewModel.test_models, id: \.self) { model in
                    if currentUser.isLogin == true { // currentUser를 활용해서 로그인 영역 제거방식
                        if model.serviceIntro != .login {
                            ServiceIntroDetailView(model: model)
                                .frame(height: geometry.size.height)
                        }
                    } else {
                        ServiceIntroDetailView(model: model)
                            .frame(height: geometry.size.height)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .animation(.none)
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct ServiceIntroView_Previews: PreviewProvider {
    @StateObject static var currentUser: UserModel = UserModel()
    static var previews: some View {
        ServiceIntroView()
            .environmentObject(currentUser)
    }
}
