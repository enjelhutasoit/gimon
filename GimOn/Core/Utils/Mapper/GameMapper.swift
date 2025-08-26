//
//  GameMapper.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation
import RealmSwift

final class GameMapper {
    static func mapGameResponsesToEntities(_ responses: [GameResponse]) -> [GameEntity] {
        responses.compactMap { response in
            let entity = GameEntity()
            entity.backgroundImage = response.backgroundImage ?? ""
            entity.genres = mapGenresToEntities(response.genres)
            entity.id = response.id
            entity.name = response.name ?? ""
            entity.parentPlatforms = mapParentPlatformsToEntities(response.parentPlatforms)
            entity.playtime = response.playtime ?? 0
            entity.rating = response.rating ?? 0.0
            entity.ratingCount = response.ratingCount ?? 0
            entity.released = response.released ?? ""
            return entity
        }
    }
    
    static func mapGameEntitiesToDomainModels(_ entities: [GameEntity]) -> [GameModel] {
        entities.map { entity in
            return GameModel(
                backgroundImage: URL(string: entity.backgroundImage) ?? URL(string: "")!,
                genres: entity.genres.compactMap { $0.name },
                id: entity.id,
                name: entity.name,
                parentPlatfroms: entity.parentPlatforms.compactMap { $0.platform?.slug },
                playtime: entity.playtime,
                rating: entity.rating,
                ratingCount: entity.ratingCount,
                released: entity.released
            )
        }
    }
    
    static func mapGameDetailResponseToEntity(_ response: GameDetailResponse) -> GameDetailEntity {
        let entity = GameDetailEntity()
        entity.backgroundImage = response.backgroundImage ?? ""
        entity.descriptionRaw = response.descriptionRaw ?? ""
        entity.developers = mapToStringList(response.developers, nameKeyPath: \.name)
        entity.esrbRating = response.esrbRating.map { $0.name ?? "" } ?? ""
        entity.genres = mapToStringList(response.genres, nameKeyPath: \.name)
        entity.id = response.id
        entity.metacritic = response.metacritic ?? 0
        entity.metacriticURL = response.metacriticURL ?? ""
        entity.name = response.name ?? ""
        entity.parentPlatforms = mapParentPlatformsToEntities(response.parentPlatforms)
        entity.playtime = response.playtime ?? 0
        entity.rating = response.rating ?? 0
        entity.ratingsCount = response.ratingsCount ?? 0
        entity.redditURL = response.redditURL ?? ""
        entity.released = response.released ?? ""
        entity.stores = mapStoresToEntities(response.stores)
        entity.tags = mapToStringList(response.tags, nameKeyPath: \.name)
        entity.website = response.website ?? ""
        return entity
    }
    
    static func mapGameDetailEntityToDomainModel(_ entity: GameDetailEntity) -> GameDetailModel {
        GameDetailModel(
            alternativeNames: Array(entity.alternativeNames),
            backgroundImage: URL(string: entity.backgroundImage),
            description: entity.descriptionRaw,
            developers: Array(entity.developers),
            esrbRating: entity.esrbRating,
            favorite: entity.favorite,
            genres: Array(entity.genres),
            id: entity.id,
            metacritic: entity.metacritic,
            metacriticURL: URL(string: entity.metacriticURL),
            name: entity.name,
            parentPlatforms: mapParentPlatformEntitiesToModels(entity.parentPlatforms),
            playtime: entity.playtime,
            rating: entity.rating,
            ratingsCount: entity.ratingsCount,
            redditURL: URL(string: entity.redditURL),
            released: entity.released,
            stores: mapStoreEntititesToModels(entity.stores),
            tags: Array(entity.tags),
            website: URL(string: entity.website)
        )
    }
}

extension GameMapper {
    private static func mapToStringList<T>(_ items: [T]?, nameKeyPath: KeyPath<T, String?>) -> List<String> {
        let list = List<String>()
        items?.forEach { item in
            let name = item[keyPath: nameKeyPath] ?? ""
            list.append(name)
        }
        return list
    }
    
    static func mapGenresToEntities(_ genres: [Genre]?) -> List<GenreEntity> {
        let genreListEntity = List<GenreEntity>()
        
        genres?.forEach { genre in
            let genreEntity = GenreEntity()
            genreEntity.name = genre.name ?? ""
            genreListEntity.append(genreEntity)
        }
        
        return genreListEntity
    }
    
    private static func mapParentPlatformsToEntities(_ parentPlatforms: [ParentPlatform]?) -> List<ParentPlatformEntity> {
        let parentPlatformListEntity = List<ParentPlatformEntity>()
        
        parentPlatforms?.forEach { parentPlatform in
            let platformEntity = PlatformEntity()
            if let platform = parentPlatform.platform {
                platformEntity.name = platform.name ?? ""
                platformEntity.slug = platform.slug ?? ""
            }
            
            let parentPlatformEntity = ParentPlatformEntity()
            parentPlatformEntity.platform = platformEntity
            
            parentPlatformListEntity.append(parentPlatformEntity)
        }
        return parentPlatformListEntity
    }
    
    private static func mapStoresToEntities(_ stores: [Store]?) -> List<StoreEntity> {
        let storeListEntity = List<StoreEntity>()
        
        stores?.forEach { store in
            let storeDetailEntity = StoreDetailEnttity()
            if let storeDetail = store.storeDetail {
                storeDetailEntity.name = storeDetail.name ?? ""
                storeDetailEntity.domain = storeDetail.domain ?? ""
            }
            
            let storeEntity = StoreEntity()
            storeEntity.storeDetail = storeDetailEntity
            
            storeListEntity.append(storeEntity)
        }
        return storeListEntity
    }
    
    private static func mapParentPlatformEntitiesToModels(_ entities: List<ParentPlatformEntity>) -> [PlatformModel] {
        return entities.map {
            PlatformModel(
                name: $0.platform?.name ?? "",
                slug: $0.platform?.slug ?? ""
            )
        }
    }
    
    private static func mapStoreEntititesToModels(_ entities: List<StoreEntity>) -> [StoreModel] {
        entities.map {
            StoreModel(
                name: $0.storeDetail?.name ?? "",
                domain: $0.storeDetail?.domain
            )
        }
    }
}
