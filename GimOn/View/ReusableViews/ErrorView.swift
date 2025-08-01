//
//  ErrorView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct ErrorView: View {
    var message: String
    var retryAction: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark")
                .font(.custom(AppFonts.bold, size: AppFontSizes.title1))
                .foregroundStyle(AppColors.primaryColor)
            
            Text(message)
                .font(.custom(AppFonts.regular, size: AppFontSizes.body))
                .foregroundStyle(AppColors.accentColor)
                .padding(.top, 10)
                .multilineTextAlignment(.center)
            
            BorderedButton("Retry") { retryAction() }
                .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
