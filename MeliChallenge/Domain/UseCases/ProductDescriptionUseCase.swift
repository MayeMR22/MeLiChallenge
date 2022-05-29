//
//  ProductDescriptionUseCase.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 27/05/22.
//

import Foundation

protocol ProductDescriptionUseCase {
    func execute(id: String, completion: @escaping (Description?, Error?) -> Void)
}

class ProductDescriptionUseCaseImpl: ProductDescriptionUseCase {
    let repository: ProductRepository
    
    init(repository: ProductRepository = ProductRepositoryImpl()) {
        self.repository = repository
    }

    func execute(id: String, completion: @escaping (Description?, Error?) -> Void) {
        repository.productDescription(itemId: id) { (description, error) in
            completion(description, error)
        }
    }
}
