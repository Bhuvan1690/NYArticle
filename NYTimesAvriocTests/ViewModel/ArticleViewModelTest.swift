//
//  ArticleViewModelTest.swift
//  NYTimesAvriocTests
//
//  Created by Bhuvan Sharma on 24/06/22.
//

import XCTest
@testable import NYTimesAvrioc

class ArticleViewModelTest: XCTestCase {

    var viewModel: ArticleViewModel!
    var networkLayer = MockNetworkLayer()
    
    override func setUp() {
        viewModel = ArticleViewModel(networkLayer: networkLayer)
    }
    
    func testArticleList_whenAPIReturnSuccessResponse() {
        viewModel.getArticles(endPoint: MockApiEndPoint.mostViewed(section: "all-section", periods: 1))
        XCTAssertNotEqual(0, viewModel.totalCount)
        XCTAssertNil(viewModel.articleAPIError.value)
    }
    
    func testArticle_whenAPIReturnErrorResponseWithWrongSection() {
        viewModel.getArticles(endPoint: MockApiEndPoint.mostViewedWrongSection(section: "section", periods: 1))
        XCTAssertEqual(0, viewModel.totalCount)
        XCTAssertNotNil(viewModel.articleAPIError.value)
    }
    
    func testArticle_whenAPIReturnErrorResponseWithWrongPeriod() {
        viewModel.getArticles(endPoint: MockApiEndPoint.mostViewedWrongPeriod(section: "all-section", periods: 3))
        XCTAssertEqual(0, viewModel.totalCount)
        XCTAssertNotNil(viewModel.articleAPIError.value)
    }

    func testCheckArticleCellViewModelForListing(){
        viewModel.getArticles(endPoint: MockApiEndPoint.mostViewed(section: "all-section", periods: 1))
        XCTAssertNotNil(viewModel.getArticleCellModel(for: 1))
    }
    
    func testCheckArticleCellViewModelForListingWhenNoData(){
        viewModel.getArticles(endPoint: MockApiEndPoint.mostViewedWrongPeriod(section: "all-section", periods: 1))
        XCTAssertNil(viewModel.getArticleCellModel(for: 1))
    }
    
    
    func testCheckArticleDetailViewModelForListing(){
        viewModel.getArticles(endPoint: MockApiEndPoint.mostViewed(section: "all-section", periods: 1))
        XCTAssertNotNil(viewModel.getArticleDetailModel(for: 1))
    }
    
    func testCheckArticleDetailViewModelForListingWhenNoData(){
        viewModel.getArticles(endPoint: MockApiEndPoint.mostViewedWrongPeriod(section: "all-section", periods: 1))
        XCTAssertNil(viewModel.getArticleDetailModel(for: 1))
    }
    
    func testCheckForArticleId(){
        viewModel.getArticles(endPoint: MockApiEndPoint.mostViewed(section: "all-section", periods: 1))
        XCTAssertEqual(100000008409150,viewModel.articleId(for: 0))
    }
    
    
}
