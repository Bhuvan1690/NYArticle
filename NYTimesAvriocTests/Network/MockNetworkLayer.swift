//
//  MockNetworkLayer.swift
//  NYTimesAvriocTests
//
//  Created by Bhuvan Sharma on 24/06/22.
//

import Foundation
@testable import NYTimesAvrioc

class MockNetworkLayer: Requestable {
    
    func responseData<T : Decodable>(endPoint: EndPointType, completion: @escaping (Result<T, Error>) -> Void){
        do {
            let data = try FileUtil.readJsonFile(name: endPoint.value)
            try completion(.success(data.decodeResponse()))
        } catch {
            completion(.failure(error))
        }
    }
}
