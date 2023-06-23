//
//  RecipeDetailsViewModel.swift
//  fetch
//
//  Created by Prince Avecillas on 6/21/23.
//

import Foundation
import UIKit

protocol RecipeDetailsViewModelDelegate: AnyObject {
    func didFinishFetch()
}

class RecipeDetailsViewModel {
    
    private let dataManager: RecipesDataManager
    private let id: String
    weak var delegate: RecipeDetailsViewModelDelegate?
    var recipe: RecipeDetails?

    init(dataManager: RecipesDataManager, id: String) {
        self.dataManager = dataManager
        self.id = id
    }
    
    func fetchData() {
        dataManager.getRecipeDetails(url: APIURL.recipeDetails(id: id).value) { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
            case .success(let data):
                self.recipe = data.meals.first
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                delegate.didFinishFetch()
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        guard let recipe = recipe else { return 0 }
        
        return recipe.ingredients.count
    }
    
    func getCellText(for indexPath: IndexPath) -> String {
        guard let recipe = recipe else { return "" }
        
        let ingredient = recipe.ingredients[indexPath.row] ?? ""
        let measurement = recipe.measurements[indexPath.row] ?? ""
        
        return "\(indexPath.row + 1). \(ingredient) - \(measurement)"
    }
}
