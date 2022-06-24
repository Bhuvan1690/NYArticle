//
//  MockApiEndPoint.swift
//  NYTimesAvriocTests
//
//  Created by Bhuvan Sharma on 24/06/22.
//

import Foundation
@testable import NYTimesAvrioc

enum MockApiEndPoint {
    case mostViewed(section : String, periods : Int)
    case mostViewedWrongSection(section : String, periods : Int)
    case mostViewedWrongPeriod(section : String, periods : Int)
}

extension MockApiEndPoint: EndPointType {
    
    var value: String {
        switch self {
        case .mostViewed:
            return "mostViewed"
        case .mostViewedWrongSection:
            return "mostViewedWrongSection"
        case .mostViewedWrongPeriod:
            return "mostViewedWrongPeriod"
        }
    }
    
    func url(params: Parameters?) -> URL {
        let urlComponents = NSURLComponents(string: self.url)!
        urlComponents.queryItems = params?.keys.map {  URLQueryItem(name: $0, value: String(describing: params![$0, default: ""])) }
        return urlComponents.url!
    }
    
    var url: String {
        let url = API_BASE_URL + "/svc/mostpopular/v2/"
        switch self {
        case .mostViewed(let section, let period):
            return url + "mostviewed/\(section)/\(period).json"
        case .mostViewedWrongSection(let section, let period):
            return url + "mostviewed/\(section)/\(period).json"
        case .mostViewedWrongPeriod(let section, let period):
            return url + "mostviewed/\(section)/\(period).json"
        }
    }
    
    var headers: Headers {
        return [:]
    }
    
}
