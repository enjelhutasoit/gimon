//
//  BorderedButton.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct BorderedButton: View {
    private let title: String
    private let fixedWidth: Bool
    private let select: () -> Void
    
    init(_ title: String, fixedWidth: Bool = true, selection: @escaping () -> Void = { }) {
        self.title = title
        self.fixedWidth = fixedWidth
        self.select = selection
    }
    
    var body: some View {
        Button {
            select()
        } label: {
            Text(title)
                .font(.custom(AppFonts.light, size: AppFontSizes.body))
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, fixedWidth ? 6 : .none)
                .frame(maxWidth: fixedWidth ? .none : .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(AppColors.primaryColor)
                )
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
        }
    }
}
