//
//  Study_RoomApp.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/12.
//

import SwiftUI
import UIKit
import NaverThirdPartyLogin

/// AppDelegate  대신해서 완성하기 -> SiwftUI 하고 UIKit 연동하기 위해서?
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        return true
    }
}

@main
struct Study_RoomApp: App {
    // appDelegate 적용
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
