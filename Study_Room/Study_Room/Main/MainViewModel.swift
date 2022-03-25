//
//  MainViewModel.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var currentTab: Tab = .ServiceInfo
//    @Published var currentTab: Tab = .Home // TODO: 나중에 메인화면 개발 완료되면 변경할 예정
}

// MARK: - TAB ITEM CASE
enum Tab: String {
    case ServiceInfo = "serviceInfo"
    case StudyExplore = "studyExplore"
    case Planner = "planner"
    case Mypage = "mypage"
    case Home = "home"
}
