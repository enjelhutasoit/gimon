//
//  FavoritesListUseCase.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Combine

protocol FavoritesListUseCase {
    func getFavoriteList() -> AnyPublisher<[GameModel], Error>
}
