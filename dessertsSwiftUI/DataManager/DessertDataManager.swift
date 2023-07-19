//
//  DessertDataManager.swift
//  dessertsSwiftUI
//
//  Created by Prince Avecillas on 7/16/23.
//

import Foundation

protocol DessertDataManaging {
    func fetchData<T: Decodable>(url: URL?) async throws -> T
}

class DessertDataManager: DessertDataManaging {
    
    func fetchData<T: Decodable>(url: URL?) async throws -> T {
        guard let url = url else {
            throw CustomError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw CustomError.noData
        }

        do {
            let results = try JSONDecoder().decode(T.self, from: data)
            return results
        } catch {
            throw CustomError.decodeError
        }
    }
}
