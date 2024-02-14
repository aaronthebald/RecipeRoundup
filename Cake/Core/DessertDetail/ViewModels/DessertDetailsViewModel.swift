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
    
    init(dataService: DessertsDataServiceProrocol) {
        self.dataService = dataService
    }
    
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
}
