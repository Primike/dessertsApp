//
//  MockRecipeDataManager.swift
//  fetchTests
//
//  Created by Prince Avecillas on 6/22/23.
//

import Foundation

class MockRecipeDataManager {
    static func getLocalData<T: Decodable>(fileName: String, type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Unable to locate file: \(fileName).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error decoding JSON data: \(error)")
            return nil
        }
    }
}
