//
//  ApiHandler.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 22/06/22.
//

import Foundation

protocol URLRequestExecutor {
    func execute(with url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLRequestExecutor {
    func execute(with url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> Void){
        let task = self.dataTask(with: url, completionHandler: callback)
        task.resume()
    }
}

class NetworkLayer: Requestable {
    
    let requestExecutor: URLRequestExecutor
    let appkey: String
    
    init(requestExecutor: URLRequestExecutor = URLSession.shared, key : String = SAMPLE_KEY) {
        self.requestExecutor = requestExecutor
        self.appkey = key;
    }
    
    func responseData<T:Codable>(endPoint: EndPointType, completion: @escaping (Result<T, Error>) -> Void){
        let url = endPoint.url(params: ["api-key": appkey])
        Logger.log(msg: url)
        requestExecutor.execute(with: url) { data, URLResponse, error in
            DispatchQueue.main.async {
                guard let data = data  else {
                    completion(.failure(error ?? NetworkError.InvalidResponse))
                    return
                }
                do {
                    try completion(.success(data.decodeResponse()))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}


