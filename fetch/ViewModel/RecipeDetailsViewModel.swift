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
    func didFailFetch()
}

enum LinkType {
    case youtube
    case source
}

protocol RecipeDetailsViewModeling {
    var delegate: RecipeDetailsViewModelDelegate? { get set }
    func fetchData()
    func getTitle() -> String
    func getDessertType() -> String
    func getInstructions() -> String
    func getLink(type: LinkType) -> URL?
    func getRecipeImageURL() -> URL?
    func getNumberOfRows() -> Int
    func getCellText(for indexPath: IndexPath) -> String
}

class RecipeDetailsViewModel: RecipeDetailsViewModeling {
    
    private let dataManager: RecipeDetailsDataManaging
    private let id: String
    weak var delegate: RecipeDetailsViewModelDelegate?
    private(set) var recipe: RecipeDetails?

    init(dataManager: RecipesDataManager, id: String) {
        self.dataManager = dataManager
        self.id = id
    }
    
    //MARK: Tests Init
    init(dataManager: RecipesDataManager, recipe: RecipeDetails, id: String) {
        self.dataManager = dataManager
        self.recipe = recipe
        self.id = id
    }
    
    //MARK: Checks if data is in cache if not it fetches data
    func fetchData() {
        if let recipe = DataCache.shared.getRecipe(id: id), let delegate = delegate {
            self.recipe = recipe
            delegate.didFinishFetch()
            return
        }

        fetchWithDataManager()
    }
    
    private func fetchWithDataManager() {
        dataManager.getRecipeDetails(url: APIURL.recipeDetails(id: id).value) { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
            case .success(let data):
                if let recipe = data.meals.first {
                    self.recipe = recipe
                    DispatchQueue.main.async {
                        DataCache.shared.addRecipe(recipe: recipe)
                        delegate.didFinishFetch()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    delegate.didFailFetch()
                }
            }
        }
    }
    
    //MARK: View methods
    func getTitle() -> String {
        return recipe?.name ?? ""
    }
    
    func getDessertType() -> String {
        return "\(recipe?.area ?? "") \(recipe?.category ?? "")"
    }
    
    func getInstructions() -> String {
        return recipe?.instructions ?? ""
    }
    
    func getLink(type: LinkType) -> URL? {
        switch type {
        case .youtube:
            return URL(string: recipe?.youtubeLink ?? "")
        case .source:
            return URL(string: recipe?.source ?? "")
        }
    }
    
    func getRecipeImageURL() -> URL? {
        guard let imageUrl = recipe?.image, let url = URL(string: imageUrl) else {
            return nil
        }
        return url
    }

    //MARK: Tableview methods
    func getNumberOfRows() -> Int {
        guard let recipe = recipe else { return 0 }
        
        return recipe.ingredients.count
    }
    
    func getCellText(for indexPath: IndexPath) -> String {
        guard let recipe = recipe else { return "" }
        
        let ingredient = recipe.ingredients[indexPath.row]
        let measurement = recipe.measurements[indexPath.row]
        
        return "\(indexPath.row + 1). \(ingredient) - \(measurement)"
    }
}
