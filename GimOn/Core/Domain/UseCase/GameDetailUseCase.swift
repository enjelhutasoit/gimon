//
//  GameDetailUseCase.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation

protocol GameDetailUseCase {
    func getGameDetail(for id: Int, completion: @escaping (Result<GameDetailModel, Error>) -> Void)
}
