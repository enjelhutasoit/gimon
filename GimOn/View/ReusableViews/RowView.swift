//
//  RowView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct RowView<T: CustomStringConvertible>: View {
    let title: String
    let values: [T]
    
    init(_ title: String, value: T) {
        self.title = title
        self.values = [value]
    }
    
    init(_ title: String, values: [T]) {
        self.title = title
        self.values = values
    }
    
    var body: some View {
        Group {
            if !values.isEmpty {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.custom(AppFonts.semiBold, size: AppFontSizes.title3))
                        .foregroundStyle(AppColors.primaryColor)
                    
                    ForEach(values, id: \.description) { value in
                        Text(value.description)
                            .font(.custom(AppFonts.light, size: AppFontSizes.body))
                            .foregroundStyle(AppColors.primaryTextColor)
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}
