//
//  Recipe.swift
//  RECIME
//
//  Created by Benjamin Bartolabac on 3/27/23.
//

import Foundation

struct Recipe: Codable,Identifiable, Hashable {
    let id: Int
    let difficulty: Diffculty
    let imageUrl: String
    let position: Int
    let title: String

    enum CodingKeys: String, CodingKey {
         case id
         case difficulty
         case imageUrl = "image_url"
         case title
         case position
     }
    
}
