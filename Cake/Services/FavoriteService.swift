//
//  FavoriteService.swift
//  Cake
//
//  Created by Aaron Wilson on 2/15/24.
//

import Foundation
import CoreData

class FavoriteService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "FavoriteContainer"
    private let entityName: String = "FavoriteEntity"
    
    @Published var savedEntities: [FavoriteEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading coredata \(error)")
            }
            self.getFavorites()
        }
    }
    
    // MARK: PUBLIC
    
    func updateFavorites(item: FoodDrink, isCocktail: Bool, deleteItem: Bool) {
        
        if let entity = savedEntities.first(where: { $0.id == item.id && $0.isCocktail == item.isCocktail }) {
            
            if deleteItem {
                delete(entity: entity)
            } else {
//                TODO: Add an alert here to let the user know they already saved this one
                print("Item already in favorites")
                return
            }
            
        } else {
            add(item: item)
        }
    }
    
    
    // MARK: PRIVATE
    private func getFavorites() {
        let request = NSFetchRequest<FavoriteEntity>(entityName: entityName)
        do {
          savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error catching portfolio entities \(error)")
        }
    }
    
    
    
    private func add(item: FoodDrink) {
        let entity = FavoriteEntity(context: container.viewContext)
        entity.id = item.id
        entity.isCocktail = item.isCocktail
        applyChanges()
    }
    
    private func delete(entity: FavoriteEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to CoreData \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getFavorites()
    }
    
}
