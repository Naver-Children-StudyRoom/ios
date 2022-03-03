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

    public func requestLoginUser(completion: @escaping ((Result<UserInfo,Error>) -> Void)) {
        // 여기서 로그인 api호출을 진행할 거고
    }
}
