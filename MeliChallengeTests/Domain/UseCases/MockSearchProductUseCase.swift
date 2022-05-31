//
//  MockSearchProductUseCase.swift
//  MeliChallengeTests
//
//  Created by Mayerly Rios on 31/05/22.
//

import XCTest
@testable import MeliChallenge

class MockSearchProductUseCase: SearchProductUseCase {
    var shouldSucceed: Bool = false
    
    func execute(parameter: SearchProductParameter, completion: @escaping (SearchResult?, Error?) -> Void) {
        if shouldSucceed {
            completion(MockService.searchResult, nil)
        } else {
            completion(nil, APINetworkError.noFound)
        }
    }
}
