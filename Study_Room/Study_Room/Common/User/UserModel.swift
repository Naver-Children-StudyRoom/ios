//
//  UserInfo.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/02/12.
//

import Foundation
import SwiftyJSON

public struct UserModel: Codable {
    public var email: String
    public var nickname: String
    public var accessToken: String
    public var refreshToken: String
    
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
}
