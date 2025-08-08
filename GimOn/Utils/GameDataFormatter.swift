//
//  GameDataFormatter.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import Foundation

func formatRatingCount(_ ratingCount: Int) -> String {
    let num = Double(ratingCount)
    switch num {
    case 1_000_000...:
        return String(format: "%.1fM", num / 1_000_000).replacingOccurrences(of: ".0", with: "")
    case 1_000...:
        return String(format: "%.1fk", num / 1_000).replacingOccurrences(of: ".0", with: "")
    default:
        return "\(ratingCount)"
    }
}

func formatPlaytime(_ playtime: Int) -> String {
    "\(playtime)h"
}

func formatRating(_ rating: Double) -> String {
    String(format: "%.1f", rating)
}

func formatYear(from dateString: String, inputDateFormat: String = "yyyy-MM-dd", to expectedDateFormat: String = "yyyy") -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = inputDateFormat
    
    guard let date = inputFormatter.date(from: dateString) else {
        return ""
    }
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = expectedDateFormat
    
    return outputFormatter.string(from: date)
}
