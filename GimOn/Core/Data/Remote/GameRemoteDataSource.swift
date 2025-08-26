////
////  GameRemoteDataSource.swift
////  GimOn
////
////  Created by Enjel Hutasoit on 26/08/25.
////

import Foundation

protocol GameRemoteDataSourceProtocol {
    func getGameList(result: @escaping (Result<[GameResponse], Error>) -> Void)
    func getGameDetail(for id: Int, result: @escaping (Result<GameDetailResponse, Error>) -> Void)
}

final class GameRemoteDataSource: NSObject {
    static let sharedInstance = GameRemoteDataSource()
    private override init() { }
}

extension GameRemoteDataSource: GameRemoteDataSourceProtocol {
    func getGameList(result: @escaping (Result<[GameResponse], Error>) -> Void) {
        guard let url = URL(string: EndPoints.Gets.gameList.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                result(.failure(NetworkError.addressUnreachable(url)))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode(GameListResponse.self, from: data)
                    result(.success(response.games))
                } catch {
                    result(.failure(NetworkError.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getGameDetail(for id: Int, result: @escaping (Result<GameDetailResponse, Error>) -> Void) {
        guard let url = URL(string: EndPoints.Gets.gameDetail(id: id).url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                result(.failure(NetworkError.addressUnreachable(url)))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode(GameDetailResponse.self, from: data)
                    result(.success(response))
                } catch {
                    result(.failure(NetworkError.invalidResponse))
                }
            }
        }
        task.resume()
    }
}
