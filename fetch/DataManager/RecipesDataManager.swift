//
//  RecipesDataManager.swift
//  fetch
//
//  Created by Prince Avecillas on 6/21/23.
//

import Foundation

protocol RecipesDataManaging {
    func getRecipesData(url: URL, completion: @escaping (Result<Meals, Error>) -> Void)
}

class RecipesDataManager: RecipesDataManaging {
    
    func getRecipesData(url: URL, completion: @escaping (Result<Meals, Error>) -> Void) {
        fetchData(url: url, customError: .noData, completion: completion)
    }
    
    private func fetchData<T: Decodable>(url: URL?, customError: CustomError, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(customError))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, _ in
            guard let data = data else {
                completion(.failure(customError))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(customError))
            }
        }
        task.resume()
    }
}
