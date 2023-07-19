//
//  DessertDetailsViewModel.swift
//  dessertsSwiftUI
//
//  Created by Prince Avecillas on 7/17/23.
//

import Foundation

enum LinkType {
    case youtube
    case source
}

class DessertDetailsViewModel: ObservableObject {
    
    private let dataManager: DessertDataManaging
    @Published var desert: RecipeDetails?
    private let id: String
    
    init(dataManager: DessertDataManaging, id: String) {
        self.dataManager = dataManager
        self.id = id
    }

    func fetchData() async throws {
        if let desert = await DessertDataCache.shared.getRecipe(id: id) {
            await MainActor.run {
                self.desert = desert
            }
            return
        }

        do {
            let data = try await dataManager.fetchData(url: APIURL.recipeDetails(id: id).value) as MealDetails
            
            await MainActor.run {
                self.desert = data.meals.first
            }
            
            await DessertDataCache.shared.addRecipe(recipe: data.meals[0])
        } catch {
            throw error
        }
    }

    //MARK: View methods
    func getTitle() -> String {
        return desert?.name ?? ""
    }
    
    func getDessertType() -> String {
        return "\(desert?.area ?? "") \(desert?.category ?? "")"
    }
    
    func getInstructions() -> String {
        return desert?.instructions ?? ""
    }
    
    func getLink(type: LinkType) -> URL? {
        switch type {
        case .youtube:
            return URL(string: desert?.youtubeLink ?? "")
        case .source:
            return URL(string: desert?.source ?? "")
        }
    }
    
    func getRecipeImageURL() -> String {
        return desert?.image ?? ""
    }

    //MARK: Tableview methods
    func getNumberOfRows() -> Int {
        guard let desert = desert else { return 0 }
        
        return desert.ingredients.count
    }
    
    func getCellText(for index: Int) -> String {
        guard let desert = desert else { return "" }
        
        let ingredient = desert.ingredients[index]
        let measurement = desert.measurements[index]
        
        return "\(index + 1). \(ingredient) - \(measurement)"
    }
}
