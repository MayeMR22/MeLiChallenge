//
//  HomeViewTest.swift
//  MeliChallengeTests
//
//  Created by Mayerly Rios on 31/05/22.
//

import XCTest
@testable import MeliChallenge

class HomeViewTest: XCTestCase {
    
    var homeViewModel: HomeViewModel!
    private var mockGetCategoryUseCase: GetCategoryUseCase!

    override func setUp() {
        super.setUp()
        mockGetCategoryUseCase = MockGetCategoryUseCase()
        homeViewModel = HomeViewModel(getCategoryUseCase: mockGetCategoryUseCase)
    }
    
    func test_GetCategorySuccessfully() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get category successfully")
        if let mock = mockGetCategoryUseCase as? MockGetCategoryUseCase {
            mock.shouldSucceed = true
        }
        homeViewModel.getCategory()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertEqual(homeViewModel.categoryList.count, 3)
    }
    
    func test_GetCategoryFailure() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get category failure")
        if let mock = mockGetCategoryUseCase as? MockGetCategoryUseCase {
            mock.shouldSucceed = false
        }
        homeViewModel.getCategory()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertEqual(homeViewModel.categoryList.count, 0)
    }
}
