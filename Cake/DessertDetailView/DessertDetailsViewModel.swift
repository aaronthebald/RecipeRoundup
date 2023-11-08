//
//  DessertDetailsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import Foundation
import Combine

class DessertDetailsViewModel: ObservableObject {
    @Published var dessertDetails: DessertDetailsModel = DessertDetailsModel(idMeal: "", strMeal: "", strDrinkAlternate: "", strCategory: "", strArea: "", strInstructions: "", strMealThumb: "", strYoutube: "", strTags: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", strSource: "", strImageSource: "", strCreativeCommonsConfirmed: "", dateModified: "")
    
    init() {
        subscribeToDessertDetails()
    }
    
    let dataService = AllDessertsDataService()
    var cancellables = Set<AnyCancellable>()
    func subscribeToDessertDetails() {
        dataService.$dessertDetails
            .sink { [weak self] dessertDetails in
                guard let dessertsDetails = dessertDetails else { return }
                self?.dessertDetails = dessertsDetails
            }
            .store(in: &cancellables)
    }
    func fetchDetails(id: String) {
        dataService.fetchDessertDetails(mealID: id)
    }
}
