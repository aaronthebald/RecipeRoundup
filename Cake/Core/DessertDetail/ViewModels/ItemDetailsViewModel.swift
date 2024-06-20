//
//  DessertDetailsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import Foundation
import Combine
import RevenueCat
import SwiftUI

class ItemDetailsViewModel: ObservableObject {
    @Published var itemDetails: Details = ItemDetailsModel.placeholderDetails
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    
    
    init(dataService: DataServiceProtocol, favoriteService: FavoriteService, proAccessManager: ProAccessManager) {
        self.dataService = dataService
        self.favoriteService = favoriteService
        self.proAccessManager = proAccessManager
        subscribeToError()
    }
    let proAccessManager: ProAccessManager
    let favoriteService: FavoriteService
    let dataService: DataServiceProtocol
    let subscriptionManager = SubscriptionService()
    let needToUpgradeErrorMessage = "Upgrade to the pro plan to save additional items to your Favorites!"
    private var cancallables = Set<AnyCancellable>()
    
    func itemIsInFavorites(isCocktail: Bool) -> Bool {
        if isCocktail {
            let item = Drink(name: itemDetails.meal, thumb: itemDetails.mealThumb, id: itemDetails.id)
            return favoriteService.itemIsInFavorites(item: item)
        } else {
            let item = FoodDrinkItem(name: itemDetails.meal, thumb: itemDetails.mealThumb, id: itemDetails.id)
            return favoriteService.itemIsInFavorites(item: item)
        }
    }
    
    func fetchDetails(id: String, isCocktail: Bool) async {
        do {
            let newDetails = try await dataService.fetchItemDetails(mealID: id, isCocktail: isCocktail)
            await MainActor.run {
                itemDetails = newDetails
            }
        } catch  {
            await MainActor.run {
                showAlert = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func addToFavorites(isCocktail: Bool, deleteItem: Bool) {
        if favoriteService.savedEntities.count >= 3 && deleteItem == false && self.proAccessManager.isProAccess == false {
            showAlert = true
            errorMessage = needToUpgradeErrorMessage
            return
        }
        if isCocktail {
            let item = Drink(name: itemDetails.meal, thumb: itemDetails.mealThumb, id: itemDetails.id)
            do {
                try favoriteService.updateFavorites(item: item, isCocktail: isCocktail, deleteItem: deleteItem)
                showAlert = true
                errorMessage = deleteItem ? "Item removed from Favorites" : "Item Added to Favorites"
            } catch  {
                showAlert = true
                errorMessage = error.localizedDescription
            }
            
        } else {
            let item = FoodDrinkItem(name: itemDetails.meal, thumb: itemDetails.mealThumb, id: itemDetails.id)
            do {
                try favoriteService.updateFavorites(item: item, isCocktail: isCocktail, deleteItem: deleteItem)
                showAlert = true
                errorMessage = deleteItem ? "Item removed from Favorites" : "Item Added to Favorites"
            } catch  {
                showAlert = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func makeSubscriptionPurchase() {
        subscriptionManager.purchase(productId: "rr_499_yearly") {
            self.proAccessManager.isProAccess = true
        }
    }
    func subscribeToError() {
        subscriptionManager.$subscriptionError
            .sink { error in
                if error != nil {
                    self.showAlert = true
                    self.errorMessage = error!.localizedDescription
                }
            }
            .store(in: &cancallables)
    }
}
