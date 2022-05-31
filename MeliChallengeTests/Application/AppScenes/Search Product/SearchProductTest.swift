//
//  SearchProductView.swift
//  MeliChallengeTests
//
//  Created by Mayerly Rios on 31/05/22.
//

import XCTest

import XCTest
@testable import MeliChallenge

class SearchProductView: XCTestCase {
    var searchProductViewModel: SearchProductViewModel!
    private var mockSearchProductUseCase: SearchProductUseCase!

    override func setUp() {
        super.setUp()
        mockSearchProductUseCase = MockSearchProductUseCase()
        searchProductViewModel = SearchProductViewModel(searchProductUseCase: mockSearchProductUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        searchProductViewModel = nil
    }
    
    func test_GetProductSearchSuccessfully() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get product search successfully")
        if let mock = mockSearchProductUseCase as? MockSearchProductUseCase {
            mock.shouldSucceed = true
        }
        searchProductViewModel.searchProduct(search: MockService.searchText, fetchMore: false)
        XCTAssertEqual(self.searchProductViewModel.offset, 20)
        XCTAssertEqual(self.searchProductViewModel.searchProduct.count, 2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
    }
    
    func test_GetProductSearchFailure() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get product search failure")
        
        if let mock = mockSearchProductUseCase as? MockSearchProductUseCase {
            mock.shouldSucceed = false
        }
        searchProductViewModel.searchProduct(search: MockService.searchText, fetchMore: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertEqual(searchProductViewModel.searchProduct.count, 0)
    }
    
    func test_UpdateProductPagingSuccessfully() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation update product paging successfully")
        if let mock = mockSearchProductUseCase as? MockSearchProductUseCase {
            mock.shouldSucceed = true
        }
        searchProductViewModel.searchProduct(search: MockService.searchText, fetchMore: true)
        XCTAssertEqual(searchProductViewModel.offset, 20)
        XCTAssertEqual(searchProductViewModel.searchProduct.count, 2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertEqual(searchProductViewModel.searchProduct.count, 2)
    }
    
    func test_UpdateProductPagingFailure() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation update product paging failure")
        if let mock = mockSearchProductUseCase as? MockSearchProductUseCase {
            mock.shouldSucceed = true
        }
        searchProductViewModel.searchProduct(search: MockService.searchText, fetchMore: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertEqual(self.searchProductViewModel.offset, 20)
        XCTAssertEqual(self.searchProductViewModel.searchProduct.count, 2)
    }

}
