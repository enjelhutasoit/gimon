//
//  CoreDataManager.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import CoreData

class CoreDataManager: ObservableObject {
    let container: NSPersistentContainer
    @Published var favoriteGames: [FavoriteGame] = []
    
    init() {
        container = NSPersistentContainer(name: "FavoriteGameEntity")
        container.loadPersistentStores { _, error in
            if let error {
                print("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func fetchFavorites() -> Result<[FavoriteGame], Error> {
        let request: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        
        do {
            let favorites = try container.viewContext.fetch(request)
            favoriteGames = favorites
            return .success(favorites)
        } catch {
            return .failure(error)
        }
    }
    
    func addFavorite(_ game: GameDetailModel) {
        let favGame = FavoriteGame(context: container.viewContext)
        favGame.backgroundImage = game.backgroundImage?.absoluteString
        favGame.genres = game.genres
        favGame.id = Int32(game.id)
        favGame.name = game.name
        favGame.rating = game.rating
        favGame.ratingCount = game.ratingCount
        favGame.released = game.released
        favGame.parentPlatforms = game.parentPlatforms.map { $0.slug }
        favGame.playtime = game.playtime
        
        saveContext()
    }
    
    func removeFavorite(_ game: GameDetailModel) {
        let request: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", game.id)

        if let existingGame = try? container.viewContext.fetch(request).first {
            container.viewContext.delete(existingGame)
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try container.viewContext.save()
        } catch {
            print("Failed to save context. \(error)")
        }
    }
}
