//
//  DataCache.swift
//  dessertsSwiftUI
//
//  Created by Prince Avecillas on 7/19/23.
//

import Foundation

actor DessertDataCache {
    
    static let shared = DessertDataCache()
    private var recipeCache = [String: RecipeDetails]()
    
    private init() {}
    
    func getRecipe(id: String) -> RecipeDetails? {
        return recipeCache[id]
    }
    
    func addRecipe(recipe: RecipeDetails) {
        guard let id = recipe.id else { return }
        recipeCache[id] = recipe
    }
}
