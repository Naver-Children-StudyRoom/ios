//
//  UserInfo.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/02/12.
//

import Foundation
import SwiftyJSON

class UserModel: ObservableObject {
    var email: String
    var nickname: String
    var accessToken: String
    var refreshToken: String
    var isLogin: Bool?
    
    init() {
        if UserDefaults.standard.bool(forKey: "isLogin") == true {
            self.isLogin = true
            self.email = UserDefaults.standard.string(forKey: "email") ?? ""
            self.nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
            self.accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
            self.refreshToken = UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        } else {
            self.isLogin = false
            self.email = ""
            self.nickname = ""
            self.accessToken = ""
            self.refreshToken = ""
        }
    }
    
    init?(json: JSON) {
        guard let email = json["email"].string,
              let nickname = json["nickname"].string,
              let accessToken = json["accessToken"].string,
              let refreshToken = json["refreshToken"].string else { return nil }
        
        self.email = email
        self.nickname = nickname
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    func loginCheck() -> Bool {
        return isLogin ?? false
    }
    
    func setInfo(model: UserModel) {
        self.email = model.email
        self.nickname = model.nickname
        self.accessToken = model.accessToken
        self.refreshToken = model.refreshToken
    }
}
