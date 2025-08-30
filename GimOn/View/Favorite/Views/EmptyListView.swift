//
//  EmptyListView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import SwiftUI

struct EmptyListView: View {
    
    private let systemImageName: String
    private let message: String
    
    init(systemImageName: String = "circle.dotted", message: String) {
        self.systemImageName = systemImageName
        self.message = message
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(systemName: systemImageName)
                .font(.custom(AppFonts.light, size: AppFontSizes.title1))
                .foregroundStyle(AppColors.primaryColor)
            Text(message)
                .font(.custom(AppFonts.light, size: AppFontSizes.body))
                .foregroundStyle(AppColors.primaryTextColor)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
