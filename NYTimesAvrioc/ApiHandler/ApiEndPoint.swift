//
//  ApiEndPoint.swift
//  NYTimesAvrioc
//
//  Created by MT11-1195 on 23/06/22.
//

import Foundation
enum ApiEndPoint {
    case mostViewed(section : String, periods : Int)
}

extension ApiEndPoint: EndPointType {
    
    var value: String {
        switch self {
        case .mostViewed:
            return "mostViewed"
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
        }
    }
    
    var headers: Headers {
        return [:]
    }
    
}
