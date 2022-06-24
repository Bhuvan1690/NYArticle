//
//  FileUtil.swift
//  NYTimesAvriocTests
//
//  Created by Bhuvan Sharma on 24/06/22.
//

import Foundation

enum FileError: Error {
    case InvalidPath
}

class FileUtil {

    static func readJsonFile(name: String, bundle: Bundle) throws -> Data {
        guard let path = bundle.path(forResource: name, ofType: "json") else {
            throw FileError.InvalidPath
        }
        return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    static func readJsonFile(name: String) throws -> Data {
        let bundle: Bundle = Bundle(for: FileUtil.self)
        return try readJsonFile(name: name, bundle: bundle)
    }
}
