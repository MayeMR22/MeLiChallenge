//
//  ProductViewControllerTest.swift
//  MeliChallengeTests
//
//  Created by Mayerly Rios on 30/05/22.
//

import XCTest
@testable import MeliChallenge

class ProductListTest: XCTestCase {
    var productListViewModel: ProductListViewModel!
    private var mockProducByCategoryUseCase: ProducByCategoryUseCase!

    override func setUp() {
        super.setUp()
        mockProducByCategoryUseCase = MockProducByCategoryUseCase()
        productListViewModel = ProductListViewModel(producByCategoryUseCase: mockProducByCategoryUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        productListViewModel = nil
    }
    
    func test_GetProductByCategorySuccessfully() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get product by category successfully")
        if let mock = mockProducByCategoryUseCase as? MockProducByCategoryUseCase {
            mock.shouldSucceed = true
        }
        productListViewModel.getProductByCategory(id: MockService.categoryId)
        XCTAssertEqual(productListViewModel.productResult.count, 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertEqual(productListViewModel.productResult.count, 1)
        XCTAssertNotNil(productListViewModel.productStatus)
    }
    
    func test_GetProductByCategoryFailure() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get product by category failure")
        if let mock = mockProducByCategoryUseCase as? MockProducByCategoryUseCase {
            mock.shouldSucceed = false
        }
        productListViewModel.getProductByCategory(id: MockService.categoryId)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        
        XCTAssertEqual(productListViewModel.productResult.count, 6)
        XCTAssertNotNil(productListViewModel.productStatus)
    }

}
