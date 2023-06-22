//
//  RecipesViewModel.swift
//  fetch
//
//  Created by Prince Avecillas on 6/21/23.
//

import Foundation

protocol RecipeViewModelDelegate: AnyObject {
    func didFinishFetch()
}

class RecipesViewModel {
    private let dataManager: RecipesDataManager
    private(set) var recipes = [Recipe]()
    private(set) var recipeSearch = [Recipe]()
    weak var delegate: RecipeViewModelDelegate?

    init(dataManager: RecipesDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchData() {
        guard let url = APIURL.recipes.value else {
            print(CustomError.invalidURL)
            return
        }
        
        dataManager.getRecipesData(url: url) { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
            case .success(let data):
                self.recipes = data.meals
                self.recipeSearch = data.meals
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                delegate.didFinishFetch()
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        return recipeSearch.count
    }
    
    func getRecipe(for indexPath: IndexPath) -> Recipe? {
        return recipeSearch[indexPath.row]
    }

    func getCellName(for indexPath: IndexPath) -> String {
        return recipeSearch[indexPath.row].name
    }

    //MARK: Removes all non lowercase alphanumerical strings in searchText and text
    func getSearchResults(searchText: String) {
        if searchText.isEmpty {
            recipeSearch = recipes
            return
        }
        
        let searchString = searchText.lowercased().filter {
            ("a"..."z" ~= $0) || ("0"..."9" ~= $0)
        }
        
        recipeSearch = recipes.filter({ recipe in
            let newText = recipe.name.lowercased().filter {
                ("a"..."z" ~= $0) || ("0"..."9" ~= $0)
            }
            
            return newText.contains(searchString)
        })
    }
}
