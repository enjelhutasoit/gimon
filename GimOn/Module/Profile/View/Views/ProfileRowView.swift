//
//  ProfileRowView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import SwiftUI

struct ProfileRowView: View {
    let title: String
    let value: String
    let select: () -> Void
    
    var body: some View {
        Button {
            select()
        } label: {
            HStack(alignment: .center) {
                Text(title)
                    .font(.custom(AppFonts.bold, size: AppFontSizes.body))
                    .frame(width: 82, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(value)
                        .lineLimit(5)
                        .multilineTextAlignment(.leading)
                    
                    Rectangle()
                        .frame(height: 0.3)
                        .foregroundStyle(AppColors.accentColor)
                }
            }
            .font(.custom(AppFonts.regular, size: AppFontSizes.body))
            .foregroundStyle(AppColors.primaryTextColor)
        }
    }
}
