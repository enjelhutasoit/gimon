//
//  LoadingView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading...")
            .progressViewStyle(
                CircularProgressViewStyle()
            )
            .foregroundStyle(AppColors.primaryColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
