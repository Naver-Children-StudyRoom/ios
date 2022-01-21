//
//  Study_RoomApp.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/12.
//

import SwiftUI

@main
struct Study_RoomApp: App {
    /// 앱에서 처음에 기본 세팅해야하는 부분에 대해서 이곳에서 처리
    /// UIKit에서 Appdelegate 가 이부분이라고 생각하면됨
    /// 기본 configuration들을 여기서 관리하자 -> 모듈화 좋은 생각
    init() {
        BootLoader.runBootLoaderModules()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
