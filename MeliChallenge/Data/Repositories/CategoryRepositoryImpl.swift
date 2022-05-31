//
//  DefaultCategoryRepository.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 24/05/22.
//

import Foundation

class CategoryRepositoryImpl: CategoryRepository {
    func getCategoryList(completion: @escaping ([CategoryModel]?, Error?) -> Void) {
        CategoryService.category.execute { (result: Result<[CategoryModel]?, Error>) in
            switch result {
            case .success(let success):
                completion(success, nil)
                return
            case .failure(let failure):
                completion(nil, failure)
                return
            }
        }
    }
}
