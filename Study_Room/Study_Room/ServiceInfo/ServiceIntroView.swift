//
//  ServiceIntroView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/21.
//

import SwiftUI

struct ServiceIntroView: View {
    @ObservedObject private var viewModel: ServiceIntroViewModel = ServiceIntroViewModel()
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ForEach(viewModel.test_models, id: \.self) { model in
                    ServiceIntroDetailView(model: model)
                        .frame(height: geometry.size.height)
                }
            }
            .listStyle(PlainListStyle())
            .animation(.none)
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct ServiceIntroView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceIntroView()
    }
}
