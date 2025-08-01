//
//  DevelopersAndAlternativeNamesView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct DevelopersAndAlternativeNamesView: View {
    let developers: [String]
    let alternativeNames: [String]
    
    var body: some View {
        Grid(
            alignment: .center,
            verticalSpacing: 21
        ) {
            GridRow(alignment: .firstTextBaseline) {
                RowView("Developers", values: developers)
                
                RowView("Alternative Name", values: alternativeNames)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
