//
//  APIURL.swift
//  fetch
//
//  Created by Prince Avecillas on 6/21/23.
//

import Foundation

enum APIURL {
    case recipes
    
    var value: URL? {
        switch self {
        case .recipes:
            return URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        }
    }
}
