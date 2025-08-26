//
//  GameListRouter.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import SwiftUI

class GameListRouter {
    func makeDetailView(for id: Int) -> some View {
        return GameDetailView(id: id)
    }
}
