//
//  Category.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 23/05/22.
//

import Foundation

struct CategoryModel : Decodable{
    let id: String?
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    static func getModelCategoryBasic() -> CategoryModel {
        return CategoryModel(id: "", name: "")
    }
}
