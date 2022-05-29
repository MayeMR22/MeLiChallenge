//
//  SearchProduct.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 27/05/22.
//

import Foundation

struct SearchResult: Decodable {
    let siteId: String
    let query: String?
    let paging: Paging?
    var results: [Results]?
    
    private enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case query
        case paging
        case results
    }
}
