//
//  RecipesModel.swift
//  fetch
//
//  Created by Prince Avecillas on 6/21/23.
//

import Foundation

struct Meals: Decodable {
    let meals: [Recipe]
}

struct Recipe: Decodable, Identifiable, Hashable {
    let name: String
    let image: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case image = "strMealThumb"
        case id = "idMeal"
    }
}
