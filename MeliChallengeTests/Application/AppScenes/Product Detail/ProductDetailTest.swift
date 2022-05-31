//
//  ProductDetailTest.swift
//  MeliChallengeTests
//
//  Created by Mayerly Rios on 31/05/22.
//

import XCTest
@testable import MeliChallenge

class ProductDetailTest: XCTestCase {
    var productDetailViewModel: ProductDetailViewModel!
    private var mockProductDescriptionUseCase: ProductDescriptionUseCase!

    override func setUp() {
        super.setUp()
        mockProductDescriptionUseCase = MockProductDescriptionUseCase()
        productDetailViewModel = ProductDetailViewModel(productDescriptionUseCase: mockProductDescriptionUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        productDetailViewModel = nil
    }
    
    func test_GetDescriptionSuccessfully() {
        if let mock = mockProductDescriptionUseCase as? MockProductDescriptionUseCase {
            mock.shouldSucceed = true
        }
        productDetailViewModel.productDescription(itemId: MockService.productId)
        XCTAssertNotNil(productDetailViewModel.productDescription)
    }
    
    func test_GetDrescriptionFailure() {
        if let mock = mockProductDescriptionUseCase as? MockProductDescriptionUseCase {
            mock.shouldSucceed = false
        }
        productDetailViewModel.productDescription(itemId: MockService.productId)
        XCTAssertNil(productDetailViewModel.productDescription)
    }

}
