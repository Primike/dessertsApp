//
//  RecipesDataManager.swift
//  fetch
//
//  Created by Prince Avecillas on 6/21/23.
//

import Foundation

protocol RecipesDataManaging {
    func getRecipesData(url: URL?, completion: @escaping (Result<Meals, Error>) -> Void)
}

protocol RecipeDetailsDataManaging {
    func getRecipeDetails(url: URL?, completion: @escaping (Result<MealDetails, Error>) -> Void)
}

class RecipesDataManager: RecipesDataManaging, RecipeDetailsDataManaging {
    
    func getRecipesData(url: URL?, completion: @escaping (Result<Meals, Error>) -> Void) {
        fetchData(url: url, completion: completion)
    }
    
    func getRecipeDetails(url: URL?, completion: @escaping (Result<MealDetails, Error>) -> Void) {
        fetchData(url: url, completion: completion)
    }

    private func fetchData<T: Decodable>(url: URL?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(CustomError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, _ in
            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(CustomError.decodeError))
            }
        }
        task.resume()
    }
}
