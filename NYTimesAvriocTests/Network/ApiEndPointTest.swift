//
//  ApiEndPointTest.swift
//  NYTimesAvriocTests
//
//  Created by Bhuvan Sharma on 24/06/22.
//

import XCTest
@testable import NYTimesAvrioc

class ApiEndPointTest: XCTestCase {

    var endPoint: EndPointType = ApiEndPoint.mostViewed(section: "all-sections", periods: 1)
    var wrongEndPoint: EndPointType = ApiEndPoint.mostViewed(section: "sections", periods: 1)
    
    func test_SampleKeyRight() throws{
        XCTAssertEqual("23E6G948xA5MIB1xOvLtVCWbNKGjmWSa", SAMPLE_KEY)
    }
    
    func test_checkQueryParameterWithSampleKey() throws {
        XCTAssertEqual("http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json?api-key=23E6G948xA5MIB1xOvLtVCWbNKGjmWSa", endPoint.url(params: ["api-key": SAMPLE_KEY]).absoluteString)
    }
    
    func test_url_withoutSampleKeyError() throws {
        XCTAssertEqual("http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json", endPoint.url(params: nil).absoluteString)
    }
    
    func test_url_withGetRightParamSuccess() throws {
        XCTAssertNotEqual("http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json", wrongEndPoint.url(params: ["api-key": SAMPLE_KEY]).absoluteString)
    }
}
