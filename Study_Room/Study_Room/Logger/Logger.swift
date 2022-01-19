//
//  Logger.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/19.
//

import Foundation
import CleanroomLogger

public func log(severity: LogSeverity, msg: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: String? = nil, errorCode: Int? = nil) {
    cleanRoomLogWrapper(severity: severity, message: msg, function: function, filePath: filePath, fileLine: fileLine, errorType: errorType, errorCode: errorCode)
}

public func debugLog(_ msg: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: String? = nil, errorCode: Int? = nil) {
    Log.debug?.trace()
    cleanRoomLogWrapper(severity: .debug, message: msg, function: function, filePath: filePath, fileLine: fileLine, errorType: errorType, errorCode: errorCode)
}

private func cleanRoomLogWrapper(severity: LogSeverity, message: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: String? = nil, errorCode: Int? = nil) {
    if let errorType = errorType {
        Log.channel(severity: severity)?.message(message, function: function, filePath: filePath, fileLine: fileLine, errorType: errorType, errorCode: errorCode)
    } else {
        Log.channel(severity: severity)?.message(message, function: function, filePath: filePath, fileLine: fileLine)
    }
}

extension LogChannel {
    
    /// 에러타입이 추가된 로그 메세지를 남긴다.
    ///
    /// - Attention: warning, error 레벨이거나 errorType 값이 존재하는 경우에는 Nelo에도 Log를 남긴다.
    func message(_ msg: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: String, errorCode: Int?) {
        let msgWithErrCode = msg.append(errorType: errorType, errorCode: errorCode)
        
        message(msgWithErrCode, function: function, filePath: filePath, fileLine: fileLine)
    }
}

extension String {
    
    private var messageDivider: String { return "__errordivider__" }
    private var errorDivider: String { return "_" }
    
    // {스트링}__errordivider__{에러타입}_{에러코드}
    fileprivate func append(errorType: String, errorCode: Int? = nil) -> String {
        let message = self + messageDivider + errorType
        
        guard let errorCode = errorCode else { return message }
        
        return message + errorDivider + String(errorCode)
    }
}
