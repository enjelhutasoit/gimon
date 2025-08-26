//
//  DataBaseError.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation

enum DatabaseError: LocalizedError {
    
    case invalidInstance
    case requestFailed
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        case .notFound: return "Not found data"
        }
    }
}
