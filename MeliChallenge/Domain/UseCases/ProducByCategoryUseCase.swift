//
//  ProducByCategoryUseCase.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 25/05/22.
//

import Foundation

protocol ProducByCategoryUseCase {
    func execute(parameter: ProducByCategoryUseCaseParameter, completion: @escaping (Product?, Error?) -> Void)
}

class ProducByCategoryUseCaseImpl: ProducByCategoryUseCase {
    let repository: ProductRepository
    
    init(repository: ProductRepository = ProductRepositoryImpl()) {
        self.repository = repository
    }

    func execute(parameter: ProducByCategoryUseCaseParameter, completion: @escaping (Product?, Error?) -> Void) {
        repository.productByCategoryList(id: parameter.categoryId) { (product, error) in
            completion(product, error)
        }
    }
}

struct ProducByCategoryUseCaseParameter {
    let categoryId: String
}
