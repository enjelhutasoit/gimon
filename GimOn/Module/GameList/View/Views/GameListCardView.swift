//
//  GameListCardView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct GameItemView: View {
    private let game: GameModel
    private let posterSize: CGSize
    private let select: () -> Void
    
    init(
        game: GameModel,
        posterSize: CGSize,
        select: @escaping () -> Void = {}
    ) {
        self.game = game
        self.posterSize = posterSize
        self.select = select
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 21) {
            PosterListView(
                game: game,
                width: posterSize.width,
                height: posterSize.height
            )
            
            GameInfoView(game: game)
        }
        .onTapGesture {
            select()
        }
    }
}
