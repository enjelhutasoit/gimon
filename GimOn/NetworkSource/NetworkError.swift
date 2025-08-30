//
//  NetworkError.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case missingApiKey
    case networkFailure
    case invalidResponse
    
    var description: String {
        switch self {
        case .missingApiKey:
            return "API key is missing. Please provide a valid API key."
        case .networkFailure:
            return "Network failure. Please check your internet connection."
        case .invalidResponse:
            return "Invalid response received from the server."
        }
    }
}
