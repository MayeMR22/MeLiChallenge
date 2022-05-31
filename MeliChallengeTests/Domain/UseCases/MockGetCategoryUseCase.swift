//
//  MockGetCategoryUseCase.swift
//  MeliChallengeTests
//
//  Created by Mayerly Rios on 30/05/22.
//

import Foundation
@testable import MeliChallenge

class MockGetCategoryUseCase: GetCategoryUseCase {
    var shouldSucceed: Bool = false
    
    func execute(completion: @escaping ([CategoryModel]?, Error?) -> Void) {
        if shouldSucceed {
            completion(MockService.categoryModel, nil)
        } else {
            completion(nil, APINetworkError.noFound)
        }
    }
}

