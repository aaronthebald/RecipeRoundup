//
//  DessertDetailsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import Foundation
import Combine

class DessertDetailsViewModel: ObservableObject {
    @Published var dessertDetails: Details = DessertDetailsModel.placeholderDetails
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    
    init(dataService: DessertsDataServiceProrocol, favoriteService: FavoriteService) {
        self.dataService = dataService
        self.favoriteService = favoriteService
    }
    
    let favoriteService: FavoriteService
    let dataService: DessertsDataServiceProrocol
    var cancellables = Set<AnyCancellable>()

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
    
    func addToFavorites(isCocktail: Bool) {
        if isCocktail {
            let item = Drink(name: dessertDetails.meal, thumb: dessertDetails.mealThumb, id: dessertDetails.id)
            favoriteService.updateFavorites(item: item, isCocktail: isCocktail, deleteItem: false)

        } else {
            let item = Dessert(name: dessertDetails.meal, thumb: dessertDetails.mealThumb, id: dessertDetails.id)
            favoriteService.updateFavorites(item: item, isCocktail: isCocktail, deleteItem: false)
        }
    }
}
