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
    
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let dataManager = RecipesDataManager()
        let viewModel = RecipesViewModel(dataManager: dataManager)
        let recipesListViewController = RecipesListViewController(viewModel: viewModel)
        recipesListViewController.coordinator = self
        
        navigationController.pushViewController(recipesListViewController, animated: true)
    }
}