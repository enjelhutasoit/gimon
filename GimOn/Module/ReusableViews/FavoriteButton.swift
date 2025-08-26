//
//  FavoriteButton.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSelected: Bool
    var onTap: () -> Void
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                onTap()
            }
        } label: {
            HStack {
                if !isSelected {
                    Text("Favorite this")
                        .font(.custom(AppFonts.light, size: AppFontSizes.body))
                        .opacity(isSelected ? 0 : 1)
                        .scaleEffect(isSelected ? 0.8 : 1)
                        .animation(.easeInOut(duration: 0.3), value: isSelected)
                }
                
                Image(systemName: isSelected ? "heart.fill" : "heart")
                    .font(.custom(AppFonts.light, size: AppFontSizes.title3))
                    .scaleEffect(isSelected ? 1.2 : 1)
                    .animation(.easeInOut(duration: 0.3), value: isSelected)
            }
            .padding(12)
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(AppColors.primaryColor, lineWidth: 1)
            }
            .foregroundColor(AppColors.primaryColor)
        }
    }
}
