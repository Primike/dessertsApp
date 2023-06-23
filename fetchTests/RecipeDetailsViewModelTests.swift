//
//  RecipeDetailsViewModelTests.swift
//  fetchTests
//
//  Created by Prince Avecillas on 6/22/23.
//

import XCTest

final class RecipeDetailsViewModelTests: XCTestCase {

    var viewModel: RecipeDetailsViewModel!

    override func setUpWithError() throws {
        guard let data = MockRecipeDataManager.getLocalData(fileName: "RecipeDetails", type: MealDetails.self)?.meals.first else {
            throw NSError(domain: "TestSetup", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to load mock data"])
        }
        viewModel = RecipeDetailsViewModel(dataManager: RecipesDataManager(), recipe: data, id: "53049")
    }

    func testGetNumberOfRows() {
        let ingredientsCount = viewModel.recipe?.ingredients.count ?? 0
        let returnedCount = viewModel.getNumberOfRows()
        
        XCTAssertEqual(ingredientsCount, returnedCount)
    }
    
    func testGetCellTextNumber() {
        let recipeTextNumber = Character("1")
        let returnedTextNumber = viewModel.getCellText(for: IndexPath(row: 0, section: 0)).first ?? "1"
        
        XCTAssertEqual(recipeTextNumber, returnedTextNumber)
    }
}
