//
//  NetworkError.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 23/06/22.
//

import Foundation

enum NetworkError: String,Error {
    case InvalidResponse = "Invalid Response"
    case BadRequest = "Bad Request"
    case NoDataFound  = "No Data Found"
}

