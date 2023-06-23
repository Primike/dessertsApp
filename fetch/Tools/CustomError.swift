//
//  CustomError.swift
//  fetch
//
//  Created by Prince Avecillas on 6/21/23.
//

import Foundation

enum CustomError: Error {
    case noData
    case cellReuse
    case invalidURL
    case decodeError
    case dataError
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "Error: No Data Available"
        case .cellReuse:
            return "Error: Unable to dequeue PersonalityTableViewCell"
        case .invalidURL:
            return "Error: Invalid URL"
        case .decodeError:
            return "Could not decode JSON"
        case .dataError:
            return "Failed to get data"
        }
    }
}
