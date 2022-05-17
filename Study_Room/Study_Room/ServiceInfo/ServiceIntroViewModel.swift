//
//  ServiceIntroViewModel.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/25.
//

import Foundation

class ServiceIntroViewModel: ObservableObject {
    @Published var models: [ServiceIntroModel]?
    @Published var test_models: [ServiceIntroModel] = [
        ServiceIntroModel(btnVisible: true, serviceIntro: .studyExplore),
        ServiceIntroModel(btnVisible: false, serviceIntro: .planner),
        ServiceIntroModel(btnVisible: true, serviceIntro: .login, buttonTitle: "Login") // 로그인 여부 판단 후 로그인이 이미 되있다면 영역 제거
    ]
    
    func removeLoginArea() {
        
    }
}

class ServiceIntroModel: NSObject {
    let btnVisible: Bool?
    let serviceIntro: ServiceIntro
    let buttonTitle: String
    
    init(btnVisible: Bool?, serviceIntro: ServiceIntro, buttonTitle: String = "자세히 알아보기") {
        self.btnVisible = btnVisible
        self.serviceIntro = serviceIntro
        self.buttonTitle = buttonTitle
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
