//
//  StoreAndExploreMore.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct StoreAndExploreMore: View {
    let stores: [StoreModel]
    let website: URL?
    let reddit: URL?
    let metacritic: URL?
    
    var body: some View {
        Grid(alignment: .top, horizontalSpacing: 21) {
            GridRow {
                VStack(alignment: .leading) {
                    Text("Stores")
                        .font(.custom(AppFonts.semiBold, size: AppFontSizes.title3))
                        .foregroundStyle(AppColors.primaryColor)
                    
                    ForEach(stores, id: \.self) { store in
                        PlainButton(
                            store.name,
                            systemImage: "icloud.and.arrow.down"
                        ) {
                            openURLInBrowser(store.domain ?? "")
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Explore More")
                        .font(.custom(AppFonts.semiBold, size: AppFontSizes.title3))
                        .foregroundStyle(AppColors.primaryColor)
                    
                    PlainButton("Website", systemImage: "link") {
                        openURLInBrowser(website)
                    }
                    
                    PlainButton("Reddit", systemImage: "link") {
                        openURLInBrowser(reddit)
                    }
                    
                    PlainButton("Metacritic", systemImage: "link") {
                        openURLInBrowser(metacritic)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
