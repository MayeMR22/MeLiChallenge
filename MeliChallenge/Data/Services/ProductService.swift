//
//  ProductService.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 25/05/22.
//

import Foundation

enum ProductService {
    case productByCategory(id: String)
    case searchProduct(search: SearchProductParameter)
    case productDescription(id: String)
}

extension ProductService: ServiceContract {
    var baseURL: String {
        return "https://api.mercadolibre.com/"
    }
    var path: String? {
        switch self {
        case .productByCategory(id: let id):
            return "sites/MCO/search?category=\(id)"
        case .searchProduct(search: let search):
            let text = search.searchText ?? ""
            let offset = search.offset ?? 0
            return "sites/MCO/search?q=\(text)&limit=20&offset=\(offset)"
        case .productDescription(id: let id):
            return "items/\(id)/description"
        }
    }
    var urlRequest: URLRequest? {
        switch self {
        case .productByCategory, .searchProduct, .productDescription:
            guard let path = path, let url = URL(string: baseURL + path) else {
                return nil
            }
            return URLRequest(url: url)
        }
    }
}
