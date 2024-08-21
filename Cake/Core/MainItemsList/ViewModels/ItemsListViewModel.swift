//
//  AllDessertsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import Foundation
import Combine
import SwiftUI

class ItemsListViewModel: ObservableObject {
    
    @Published var items: [FoodDrink] = []
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    @Published var imageData: [String : Data] = [:]
    @Published var filterString: String = ""
    @Published var categories: [Category] = []
    @Published var selectedCategory: String = "Beef"
    @Published var isCocktail: Bool = false
    @Published var showFavorites: Bool = false
    @Published var showSettingSheet: Bool = false
    @Published var viewIsLoading: Bool = true
    
    init(dataService: DataServiceProtocol, cacheService: CacheServiceProtocol) {
        self.dataService = dataService
        self.cacheService = cacheService
        Task {
            await fetchCategories()
            await fetchItems(category: selectedCategory)
        }
    }
    
    let favoriteService = FavoriteService()
    let dataService: DataServiceProtocol
    let cacheService: CacheServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    var filteredItems: [FoodDrink] {
        if filterString == "" {
           let sortedDesserts = items.sorted(by: {$0.name < $1.name})
            return sortedDesserts
        } else {
            let sortedDesserts = items.sorted(by: {$0.name < $1.name})
            return sortedDesserts.filter({$0.name.contains(filterString)})
        }
    }
    
    var favoriteItems: [FoodDrink] {
        let favoriteEntities = favoriteService.savedEntities
        var itemsArray: [FoodDrink] = []
        for entity in favoriteEntities {
            if entity.isCocktail {
                if
                    let name = entity.name,
                    let thumb = entity.thumb,
                    let id = entity.id {
                    let newItem = Drink(name: name, thumb: thumb, id: id)
                    itemsArray.append(newItem)
                }
            } else {
                if
                    let name = entity.name,
                    let thumb = entity.thumb,
                    let id = entity.id {
                    let newItem = FoodDrinkItem(name: name, thumb: thumb, id: id)
                    itemsArray.append(newItem)
                }
            }
        }
        return itemsArray
    }
    
    func fetchCategories() async {
        do {
            let categories = try await dataService.fetchAllCategories()
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
            await MainActor.run {
                self.viewIsLoading = true
            }
            let drinks = try await dataService.fetchAllCocktails()
            await MainActor.run {
                self.items = drinks
                viewIsLoading = false
            }
        } catch {
            viewIsLoading = false
            print(error.localizedDescription)
        }
    }
    
    func fetchItems(category: String) async {
        do {
            await MainActor.run {
                self.viewIsLoading = true
            }
            let newItems = try await dataService.fetchItems(category: category)
            await MainActor.run {
                self.items = newItems
                self.viewIsLoading = false
            }
        } catch {
            await MainActor.run {
                self.viewIsLoading = false
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
    
    func showFavoritesList() async {
      await MainActor.run {
        filterString = ""
        showFavorites = true
        isCocktail = false
      }
    }
    
    func showCocktailList() async {
      await MainActor.run {
        filterString = ""
        isCocktail = true
        selectedCategory = ""
      }
        await fetchAllCocktails()
    }
    
    func showSelectedCategory(category: String) async {
      await MainActor.run {
        filterString = ""
        showFavorites = false
        selectedCategory = category
      }
    }
    
    func shouldCocktailsBeUnderlined() -> Bool {
        if isCocktail && !showFavorites && selectedCategory == "" {
            return true
        } else {
            return false
        }
    }
    
    func shouldFoodCategoryBeUnderlined(category: String) -> Bool {
        if selectedCategory == category && showFavorites == false {
            return true
        } else {
            return false
        }
    }
    
}
