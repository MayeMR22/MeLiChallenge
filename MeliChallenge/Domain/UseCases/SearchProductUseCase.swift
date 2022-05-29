//
//  SearchProductUseCase.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 27/05/22.
//

import Foundation

protocol SearchProductUseCase {
    func execute(parameter: SearchProductParameter, completion: @escaping (SearchResult?, Error?) -> Void)
}

class SearchProductUseCaseImpl: SearchProductUseCase {
    let repository: ProductRepository
    
    init(repository: ProductRepository = ProductRepositoryImpl()) {
        self.repository = repository
    }

    func execute(parameter: SearchProductParameter, completion: @escaping (SearchResult?, Error?) -> Void) {
        repository.searchProduct(search: parameter) { (search, error) in
            completion(search, error)
        }
    }
}

struct SearchProductParameter {
    let searchText: String?
    let offset: Int?
}
