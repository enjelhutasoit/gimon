//
//  SharpEdgeDivider.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct SharpEdgeDivider: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            .clear,
                            AppColors.primaryColor,
                            .clear
                        ]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 2)
    }
}
