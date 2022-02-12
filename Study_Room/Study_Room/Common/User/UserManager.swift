//
//  UserManager.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/02/12.
//

import Foundation
import Alamofire
import SwiftyJSON

open class UserManager {
    public static let shared = UserManager()
    
    public var userInfo: UserInfo?
}
