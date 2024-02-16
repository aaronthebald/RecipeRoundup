//
//  AllDessertsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import Foundation
import Combine
import SwiftUI

class AllDessertsViewModel: ObservableObject {
    
    @Published var items: [FoodDrink] = []
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    @Published var imageData: [String : Data] = [:]
    @Published var filterString: String = ""
    @Published var categories: [Category] = []
    @Published var selectedCategory: String = "Beef"
    @Published var isCocktail: Bool = false
    @Published var showFavorites: Bool = false
    
    init(dataService: DessertsDataServiceProrocol, cacheService: CacheServiceProtocol) {
        self.dataService = dataService
        self.cacheService = cacheService
        Task {
            await fetchCategories()
            await fetchDesserts(category: selectedCategory)
        }
    }
    
    private let favoriteService = FavoriteService()
    let dataService: DessertsDataServiceProrocol
    let cacheService: CacheServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    var filteredDesserts: [FoodDrink] {
        /*
         Tomorrow i need to set up the array of favorite entities. Creating FoodDrink items for each entity. I cant filter on the items array because they may not be in there so i need to init each object and then append them to an array. then the items array can reflect that array. then the view can have a for each loop because both food and drink adhere to the FoodDrink protocol.
         */
        if filterString == "" {
           let sortedDesserts = items.sorted(by: {$0.name < $1.name})
            return sortedDesserts
        } else {
            let sortedDesserts = items.sorted(by: {$0.name < $1.name})
            return sortedDesserts.filter({$0.name.contains(filterString)})
        }
    }
    
    func fetchCategories() async {
        do {
            let categories = try await dataService.fetchAllCatagories()
            await MainActor.run {
                self.categories = categories
            }
        } catch {
            await MainActor.run {
                self.showAlert = true
                self.errorMessage = "There was an error \(error.localizedDescription)"
            }
        }
    }
    
    func fetchAllCocktails() async {
        do {
            let drinks = try await dataService.fetchAllCocktails()
            await MainActor.run {
                self.items = drinks
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchDesserts(category: String) async {
        do {
            let newDesserts = try await dataService.fetchAllDesserts(category: category)
            await MainActor.run {
                self.items = newDesserts
            }
        } catch {
            await MainActor.run {
                self.showAlert = true
                self.errorMessage = "There was an error \(error.localizedDescription)"
            }
        }
    }
    
    func getImageData(thumbURL: String) async {
        do {
            let returnedData = try await dataService.getImageData(thumbnailURL: thumbURL)
            await MainActor.run {
                cacheService.addImage(imageData: returnedData as NSData, thumbURL: thumbURL)
                imageData.updateValue(returnedData, forKey: thumbURL)
            }
        } catch {
            await MainActor.run {
                if error.localizedDescription == "cancelled" {
                    return
                } else {
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
    
}
