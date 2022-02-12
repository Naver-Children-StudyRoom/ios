//
//  UserInfo.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/02/12.
//

import Foundation
import SwiftyJSON

public struct UserInfo: Codable {
    public var id: String
    public var pw: String
    public var nickname: String
    public var accessToken: String
    
    init?(json: JSON) {
        guard let id = json["id"].string,
              let pw = json["pw"].string,
              let nickname = json[""].string,
              let accessToken = json[""].string else { return nil }
        
        self.id = id
        self.pw = pw
        self.nickname = nickname
        self.accessToken = accessToken
    }
}
