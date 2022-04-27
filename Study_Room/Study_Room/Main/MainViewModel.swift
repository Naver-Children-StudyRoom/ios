//
//  MainViewModel.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var currentTab: Tab = .Home
}

// MARK: - TAB ITEM CASE
enum Tab: String {
    case ServiceInfo = "serviceInfo"
    case StudyExplore = "studyExplore"
    case Planner = "planner"
    case Mypage = "mypage"
    case Home = "home"
}
