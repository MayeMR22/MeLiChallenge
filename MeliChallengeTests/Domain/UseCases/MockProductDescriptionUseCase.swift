//
//  MockProductDescriptionUseCase.swift
//  MeliChallengeTests
//
//  Created by Mayerly Rios on 31/05/22.
//

import XCTest
@testable import MeliChallenge

class MockProductDescriptionUseCase: ProductDescriptionUseCase {
    var shouldSucceed: Bool = false
    
    func execute(id: String, completion: @escaping (Description?, Error?) -> Void) {
        if shouldSucceed {
            completion(MockService.description, nil)
        } else {
            completion(nil, APINetworkError.noFound)
        }
    }
}
