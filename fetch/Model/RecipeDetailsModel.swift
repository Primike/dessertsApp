//
//  RecipeDetailsModel.swift
//  fetch
//
//  Created by Prince Avecillas on 6/22/23.
//

import Foundation

struct MealDetails: Decodable {
    let meals: [RecipeDetails]
}

struct RecipeDetails: Decodable {
    let id: String?
    let name: String?
    let category: String?
    let area: String?
    let youtubeLink: String?
    let instructions: String?
    let image: String?
    var ingredients: [String]
    var measurements: [String]
    let source: String?

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case image = "strMealThumb"
        case youtubeLink = "strYoutube"
        case source = "strSource"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        youtubeLink = try container.decodeIfPresent(String.self, forKey: .youtubeLink)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        ingredients = try RecipeDetails.decodeIngredientsMeasurements(container: decoder.container(keyedBy: IngredientsKeys.self))
        measurements = try RecipeDetails.decodeIngredientsMeasurements(container: decoder.container(keyedBy: MeasurementsKeys.self))
    }

    static private func decodeIngredientsMeasurements<T: CodingKey>(container: KeyedDecodingContainer<T>) throws -> [String] {
        var values: [String] = []
        
        for key in container.allKeys {
            if let value = try container.decodeIfPresent(String.self, forKey: key),
                !value.trimmingCharacters(in: .whitespaces).isEmpty {
                values.append(value)
            }
        }
        return values
    }
}

protocol IngredientMeasurementKey: CodingKey, CaseIterable {}

extension RecipeDetails {
    enum IngredientsKeys: String, IngredientMeasurementKey {
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
        strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
        strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
        strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
    }

    enum MeasurementsKeys: String, IngredientMeasurementKey {
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
        strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
        strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
        strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
}
