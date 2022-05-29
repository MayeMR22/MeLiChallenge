//
//  ProductRepository.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 25/05/22.
//

import Foundation

protocol ProductRepository {
    func productByCategoryList(id: String, completion: @escaping (Product?, Error?) -> Void)
    func searchProduct(search: SearchProductParameter, completion: @escaping (SearchResult?, Error?) -> Void)
    func productDescription(itemId: String, completion: @escaping (Description?, Error?) -> Void)
}

