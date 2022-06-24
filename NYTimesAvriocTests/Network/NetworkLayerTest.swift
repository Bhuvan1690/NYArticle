//
//  NetworkLayerTest.swift
//  NYTimesAvriocTests
//
//  Created by Bhuvan Sharma on 24/06/22.
//

import XCTest
@testable import NYTimesAvrioc

class NetworkLayerTest: XCTestCase {

    var mockedRequestExecutor: MockedRequestExecutor!
    override func setUp() {
        mockedRequestExecutor = MockedRequestExecutor()
    }
    
    func testGet_whenSucceed() throws {
        let exp = expectation(description: "check success response")
        let liveNetworkClient = NetworkLayer()
        liveNetworkClient.responseData(endPoint: MockApiEndPoint.mostViewed(section: "all-section", periods: 1)) { (result: Result<Response, Error>) in
            switch result {
            case .success(let model):
                XCTAssertNil(model.fault)
                XCTAssertEqual("OK", model.status)
            case .failure:
                XCTFail("Not should be fail")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }
    
    func testGet_whenQueryParameterWrong() throws {
        let exp = expectation(description: "check nil response")
        let liveNetworkClient = NetworkLayer()
        liveNetworkClient.responseData(endPoint: MockApiEndPoint.mostViewed(section: "section", periods: 1)) { (result: Result<Response, Error>) in
            switch result {
            case .success(let model):
                XCTAssertNil(model.fault)
                XCTAssertEqual("OK", model.status)
                XCTAssertEqual(0, model.results.count)
            case .failure:
                XCTFail("Not should be fail")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }
    
    func testGet_whenAppKeyIsNotCorrect() throws {
        let exp = expectation(description: "check bad request")
        let liveNetworkClient = NetworkLayer(key: "wrongkey")
        liveNetworkClient.responseData(endPoint: MockApiEndPoint.mostViewed(section: "all-section", periods: 1)) { (result: Result<Response, Error>) in
            switch result {
            case .success(let model):
                XCTAssertNotNil(model.fault)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testGet_whenSessionReturnError() throws {
        mockedRequestExecutor.executeClosure = { url, callback in
            callback(nil, HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil), NetworkError.BadRequest)
        }
        let liveNetworkClient = NetworkLayer(requestExecutor: mockedRequestExecutor)
        liveNetworkClient.responseData(endPoint: MockApiEndPoint.mostViewed(section: "all-section", periods: 1)) { (result: Result<Response, Error>) in
            switch result {
            case .success(_):
                XCTFail("Should return bad request error")
            case .failure(let error):
                XCTAssertEqual(NetworkError.BadRequest, error as! NetworkError)
            }
        }
        XCTAssertEqual(mockedRequestExecutor.executeCount, 1)
    }
    
    
    func testGet_whenJsonNotParsable() throws {
        let data = """
          {
              "heading" : "news"
          }
          """.data(using: .utf8)!
        mockedRequestExecutor.executeClosure = { url, callback in
            callback(data, HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil), NetworkError.BadRequest)
        }
        let liveNetworkClient = NetworkLayer(requestExecutor: mockedRequestExecutor)
        liveNetworkClient.responseData(endPoint: MockApiEndPoint.mostViewed(section: "all-section", periods: 1)) { (result: Result<Response, Error>) in
            switch result {
            case .success(_):
                XCTFail("Should return bad request error")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        XCTAssertEqual(mockedRequestExecutor.executeCount, 1)
    }
}


class MockedRequestExecutor: URLRequestExecutor {
    
    func execute(with url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        executeCount += 1
        self.executeClosure(url, callback)
    }
    
    var executeCount = 0
    var executeClosure: ( _ url: URL, _ callback: @escaping (Data?, URLResponse?, Error?) -> Void) -> Void = { _, _ in
        XCTFail("execute closure not set")
    }
}
