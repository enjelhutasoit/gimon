//
//  GameMetadataView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct GameMetadataView: View {
    let esrb: String
    let metacritic: String
    let playtime: String
    let released: String
    
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 21) {
            GridRow {
                PlainButton("Released: \(released)", systemImage: "calendar")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                PlainButton("Metacritic: \(metacritic)", systemImage: "gauge")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            GridRow {
                PlainButton("Playtime: \(playtime)", systemImage: "clock")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                PlainButton("ESRB: \(esrb)", systemImage: "exclamationmark.shield")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .font(.custom(AppFonts.regular, size: AppFontSizes.body))
        .foregroundStyle(AppColors.primaryTextColor)
    }
}
