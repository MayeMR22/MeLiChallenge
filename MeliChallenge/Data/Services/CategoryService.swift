//
//  CategoryService.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 24/05/22.
//

import Foundation

enum CategoryService {
    case category
}

extension CategoryService: ServiceContract {
    var baseURL: String {
        return "https://api.mercadolibre.com/"
    }
    var path: String? {
        switch self {
        case .category:
            return "sites/MLA/categories"
        }
    }
    var urlRequest: URLRequest? {
        switch self {
        case .category:
            guard let path = path,
                  let url = URL(string: baseURL + path) else {
                return nil
            }
            return URLRequest(url: url)
        }
    }
}
