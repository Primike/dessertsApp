//
//  DataCache.swift
//  fetch
//
//  Created by Prince Avecillas on 6/23/23.
//

import Foundation

class DataCache {
    
    static let shared = DataCache()
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
