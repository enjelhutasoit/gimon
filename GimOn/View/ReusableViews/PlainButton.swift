//
//  PlainButton.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct PlainButton: View {
    private let title: String
    private let systemImage: String
    private let action: () -> Void
    
    init(
        _ title: String,
        systemImage: String,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: systemImage)
                    .foregroundStyle(AppColors.primaryColor)
                
                Text(title)
                    .foregroundStyle(AppColors.primaryTextColor)
            }
            .font(.custom(AppFonts.light, size: AppFontSizes.body))
        }
    }
}
