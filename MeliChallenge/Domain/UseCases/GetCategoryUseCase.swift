//
//  GetCategoryUseCase.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 23/05/22.
//

import Foundation

protocol GetCategoryUseCase {
    func execute(completion: @escaping ([Category]?, Error?) -> Void)
}

class GetCategoryUseCaseImpl: GetCategoryUseCase {
    
    let repository : CategoryRepository
    
    init(repository : CategoryRepository = CategoryRepositoryImpl()) {
        self.repository = repository
    }
    func execute(completion: @escaping ([Category]?, Error?) -> Void) {
        repository.getCategoryList { (category, error) in
            completion(category, error)
        }
    }
}
