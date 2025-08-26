//
//  GameDetailUseCase.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Combine

protocol GameDetailUseCase {
    func getGameDetail(for id: Int) -> AnyPublisher<GameDetailModel, Error>
}
