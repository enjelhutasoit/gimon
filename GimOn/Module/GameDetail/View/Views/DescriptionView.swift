//
//  DescriptionView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct DescriptionView: View {
    private let title: String
    private let description: String
    @Binding var isDescriptionExpanded: Bool
    
    init(
        title: String,
        description: String,
        isDescriptionExpanded: Binding<Bool>
    ) {
        self.title = title
        self.description = description
        self._isDescriptionExpanded = isDescriptionExpanded
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom(AppFonts.semiBold, size: AppFontSizes.title3))
                .foregroundStyle(AppColors.primaryColor)
            
            Text(description)
                .font(.custom(AppFonts.light, size: AppFontSizes.body))
                .foregroundStyle(AppColors.primaryTextColor)
                .lineLimit(isDescriptionExpanded ? nil : 3)
                .truncationMode(.tail)
            
            Button {
                withAnimation {
                    isDescriptionExpanded.toggle()
                }
            } label: {
                HStack(alignment: .top, spacing: 8) {
                    Text(isDescriptionExpanded ? "Read less" : "Read more")
                        .font(.custom(AppFonts.semiBold, size: AppFontSizes.body))
                        .foregroundStyle(.white)
                    
                    Image(systemName: isDescriptionExpanded ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                        .font(.custom(AppFonts.semiBold, size: AppFontSizes.body))
                        .foregroundColor(AppColors.primaryColor)
                }
            }
        }
    }
}
