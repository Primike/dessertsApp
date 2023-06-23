//
//  RecipesCoordinator.swift
//  fetch
//
//  Created by Prince Avecillas on 6/20/23.
//

import Foundation
import UIKit

class RecipesCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let dataManager = RecipesDataManager()
        let viewModel = RecipesViewModel(dataManager: dataManager)
        let recipesListViewController = RecipesListViewController(viewModel: viewModel)
        recipesListViewController.coordinator = self
        
        navigationController.pushViewController(recipesListViewController, animated: true)
    }
    
    //MARK: Goes to details VC
    func goToRecipeDetails(id: String) {
        let dataManager = RecipesDataManager()
        let viewModel = RecipeDetailsViewModel(dataManager: dataManager, id: id)
        let recipeDetailsViewController = RecipeDetailsViewController(viewModel: viewModel)
        recipeDetailsViewController.coordinator = self
        
        navigationController.pushViewController(recipeDetailsViewController, animated: true)
    }
}
