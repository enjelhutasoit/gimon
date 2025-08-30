//
//  GameListUseCase.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Combine

protocol GameListUseCase {
    func getGameList() -> AnyPublisher<[GameModel], Error>
}
