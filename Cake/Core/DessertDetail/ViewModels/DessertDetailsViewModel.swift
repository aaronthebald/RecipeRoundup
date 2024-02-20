//
//  DessertDetailsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import Foundation
import Combine
import RevenueCat

class DessertDetailsViewModel: ObservableObject {
    @Published var dessertDetails: Details = DessertDetailsModel.placeholderDetails
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    
    init(dataService: DessertsDataServiceProrocol, favoriteService: FavoriteService) {
        self.dataService = dataService
        self.favoriteService = favoriteService
        Purchases.shared.getCustomerInfo { info, error in
            if info?.entitlements["proaccess"]?.isActive == true {
                self.isProAccess = true
            }
        }
    }
    
    let favoriteService: FavoriteService
    let dataService: DessertsDataServiceProrocol
    var isProAccess: Bool = false
    
    func itemIsInFavorites(isCocktail: Bool) -> Bool {
        if isCocktail {
            let item = Drink(name: dessertDetails.meal, thumb: dessertDetails.mealThumb, id: dessertDetails.id)
            return favoriteService.itemIsInFavorites(item: item)
        } else {
            let item = Dessert(name: dessertDetails.meal, thumb: dessertDetails.mealThumb, id: dessertDetails.id)
            return favoriteService.itemIsInFavorites(item: item)
        }
    }
    
    func fetchDetails(id: String, isCocktail: Bool) async {
        do {
            let newDetails = try await dataService.fetchDessertDetails(mealID: id, isCocktail: isCocktail)
           await MainActor.run {
                dessertDetails = newDetails
            }
        } catch  {
            await MainActor.run {
                showAlert = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func addToFavorites(isCocktail: Bool, deleteItem: Bool) {
        if favoriteService.savedEntities.count >= 3 && deleteItem == false && isProAccess == false {
            showAlert = true
            errorMessage = "To save more than 5 items to your Favorites please upgrade to the pro plan"
            return
        }
        if isCocktail {
            let item = Drink(name: dessertDetails.meal, thumb: dessertDetails.mealThumb, id: dessertDetails.id)
            do {
                try favoriteService.updateFavorites(item: item, isCocktail: isCocktail, deleteItem: deleteItem)
                showAlert = true
                errorMessage = deleteItem ? "Item removed from Favorites" : "Item Added to Favorites"
            } catch  {
                showAlert = true
                errorMessage = error.localizedDescription
            }
            
        } else {
            let item = Dessert(name: dessertDetails.meal, thumb: dessertDetails.mealThumb, id: dessertDetails.id)
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
        SubscriptionService.purchase(productId: "rr_499_yearly") {
            self.isProAccess = true
        }
    }
}
