//
//  MockProducByCategoryUseCase.swift
//  MeliChallengeTests
//
//  Created by Mayerly Rios on 30/05/22.
//

import Foundation
@testable import MeliChallenge

class MockProducByCategoryUseCase: ProducByCategoryUseCase {
    var shouldSucceed: Bool = false
    
    func execute(parameter: ProducByCategoryUseCaseParameter, completion: @escaping (Product?, Error?) -> Void) {
        if shouldSucceed {
            completion(MockService.productModel, nil)
        } else {
            completion(nil, APINetworkError.noFound)
        }
    }
}
