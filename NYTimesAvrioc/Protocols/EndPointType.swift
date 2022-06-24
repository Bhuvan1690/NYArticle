//
//  EndPointType.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 23/06/22.
//

import Foundation

public typealias Headers = [String : String]

public protocol EndPointType {
    var headers: Headers { get }
    var value: String { get }
    func url(params: Parameters?) -> URL
}
