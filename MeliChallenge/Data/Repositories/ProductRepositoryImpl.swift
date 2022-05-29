//
//  ProductRepositoryImpl.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 25/05/22.
//

import Foundation

class ProductRepositoryImpl: ProductRepository {
    func searchProduct(search: SearchProductParameter, completion: @escaping (SearchResult?, Error?) -> Void) {
        ProductService.searchProduct(search: search).execute { (result: Result<SearchResult?, Error>) in
            switch result {
            case .success(let search):
                completion(search, nil)
                return
            case .failure(let failure):
                completion(nil, failure)
                return
            }
        }
    }
    
    func productDescription(itemId: String, completion: @escaping (Description?, Error?) -> Void) {
        ProductService.productDescription(id: itemId).execute { (result: Result<Description?, Error>) in
            switch result {
            case .success(let description):
                completion(description, nil)
                return
            case .failure(let failure):
                completion(nil, failure)
                return
            }
        }
    }
    
    func productByCategoryList(id: String, completion: @escaping (Product?, Error?) -> Void) {
        ProductService.productByCategory(id: id).execute { (result: Result<Product?, Error>) in
            switch result {
            case .success(let product):
                completion(product, nil)
                return
            case .failure(let failure):
                completion(nil, failure)
                return
            }
        }
    }
}
