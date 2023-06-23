//
//  fetchTests.swift
//  fetchTests
//
//  Created by Prince Avecillas on 6/22/23.
//

import XCTest
@testable import fetch

final class RecipeViewModelTests: XCTestCase {

    var viewModel: RecipesViewModel!

    override func setUpWithError() throws {
        guard let data = MockRecipeDataManager.getLocalData(fileName: "Recipes", type: Meals.self)?.meals else {
            throw NSError(domain: "TestSetup", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to load mock data"])
        }
        viewModel = RecipesViewModel(dataManager: RecipesDataManager(), recipes: data)
    }

    func testGetNumberOfRows() {
        XCTAssertEqual(viewModel.recipes.count, 64)
        XCTAssertEqual(viewModel.recipeSearch.count, 64)
    }
    
    func testGetRecipeID() {
        let recipeId = viewModel.recipes.first?.id ?? ""
        let returnedId = viewModel.getRecipeID(for: IndexPath(row: 0, section: 0))
        XCTAssertEqual(recipeId, returnedId)
    }
    
    func testGetSearchResults() {
        viewModel.getSearchResults(searchText: "Cheese")
        XCTAssertEqual(viewModel.recipeSearch.count, 3)
    }
    
    func testCompressText() {
        XCTAssertEqual(viewModel.compressText(text: "QWE /./.,%12x"), "qwe12x")
    }
    
    func testGetCellName() {
        let recipeName = viewModel.recipes.first?.name ?? ""
        let returnedName = viewModel.getCellName(for: IndexPath(row: 0, section: 0))
        XCTAssertEqual(recipeName, returnedName)
    }
    
    func testGetCellImageURL() {
        let recipeURL = viewModel.recipes.first?.image ?? ""
        let returnedURL = viewModel.getCellImageURL(for: IndexPath(row: 0, section: 0))
        XCTAssertEqual(recipeURL, returnedURL)
    }
}
