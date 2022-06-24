//
//  JSONDecoder+Extension.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 23/06/22.
//

import Foundation

extension Data {
    func decodeResponse<T: Decodable>() throws -> T {
        Logger.log(data: self)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: self)
    }
}
