//
//  Logger.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 23/06/22.
//

import Foundation

class Logger {
    static func log(msg: Any, file: String = #fileID, function: String = #function, line: UInt = #line) {
        #if DEBUG
        print("\(Date()) \(function) :\(line) -> \(msg)")
        #endif
    }
    
    static func log(data: Data, file: String = #fileID, function: String = #function, line: UInt = #line) {
        let msg = String(data: data, encoding: .utf8) ?? "API response is empty"
        log(msg: msg, file: file, function: function, line: line)
    }
}
