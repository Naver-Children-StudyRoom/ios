//
//  ServiceIntroViewModel.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/25.
//

import Foundation

class ServiceIntroViewModel: ObservableObject {
    @Published var models: [ServiceIntroModel]?
    @Published var test_models: [ServiceIntroModel] = [ServiceIntroModel(btnVisible: true, serviceIntro: .studyExplore),ServiceIntroModel(btnVisible: true, serviceIntro: .planner),ServiceIntroModel(btnVisible: false, serviceIntro: .login)]
}

class ServiceIntroModel: NSObject {
    let btnVisible: Bool?
    let serviceIntro: ServiceIntro
    
    init(btnVisible: Bool?, serviceIntro: ServiceIntro) {
        self.btnVisible = btnVisible
        self.serviceIntro = serviceIntro
    }
}

enum ServiceIntro: Int, CaseIterable {
    case studyExplore
    case studyRoom
    case planner
    case login
    
    var imageName: String {
        switch self {
        case .studyExplore: return "studyExplore"
        case .studyRoom: return "studyRoom"
        case .planner: return "planner"
        case .login: return "Login"
        }
    }
    
    var description: String {
        switch self {
        case .studyExplore: return "studyExplore"
        case .studyRoom: return "studyRoom"
        case .planner: return "planner"
        case .login: return "Login"
        }
    }
}
