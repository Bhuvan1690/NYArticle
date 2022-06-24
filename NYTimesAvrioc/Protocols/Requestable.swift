//
//  Requestable.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 23/06/22.
//

import Foundation

public typealias Parameters = [String : Any]

protocol Requestable {

    func responseData<T:Codable>(endPoint: EndPointType, completion: @escaping (Result<T, Error>) -> Void)
}
