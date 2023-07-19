//
//  DessertViewModel.swift
//  dessertsSwiftUI
//
//  Created by Prince Avecillas on 7/16/23.
//

import Foundation

class DessertViewModel: ObservableObject {
    
    private let dataManager: DessertDataManaging
    private(set) var deserts = [Recipe]()
    @Published var dessertSearch = [Recipe]()
    
    init(dataManager: DessertDataManaging) {
        self.dataManager = dataManager
    }

    func fetchData() async throws {
        do {
            let data = try await dataManager.fetchData(url: APIURL.recipes.value) as Meals
            
            await MainActor.run {
                self.deserts = data.meals
                self.dessertSearch = data.meals
            }
        } catch {
            throw error
        }
    }
    
    //MARK: Compresses And Matches Texts
    func getSearchResults(searchText: String) {
        if searchText.isEmpty {
            dessertSearch = deserts
            return
        }
        
        let searchString = compressText(text: searchText)
        
        dessertSearch = deserts.filter({ dessert in
            let newText = compressText(text: dessert.name)
            
            return newText.contains(searchString)
        })
    }
    
    //MARK: Converts String Into An Alphanumerical, Lowercased, Spaceless String
    func compressText(text: String) ->  String {
        return text.lowercased().filter {
            ("a"..."z" ~= $0) || ("0"..."9" ~= $0)
        }
    }
}
