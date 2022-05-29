//
//  Description.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 27/05/22.
//

import Foundation

struct Description: Decodable {
    
    let plainText : String
    
    private enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
    }
}
