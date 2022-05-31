//
//  CategoryRepository.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 23/05/22.
//

import Foundation

protocol CategoryRepository {
    func getCategoryList(completion: @escaping ([CategoryModel]?, Error?) -> Void)
}
