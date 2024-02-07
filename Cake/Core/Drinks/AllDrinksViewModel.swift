//
//  AllDrinksViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 2/4/24.
//

import Foundation

class AllDrinksViewModel: ObservableObject {
    
    @Published var AllDrinks: [Drink] = []
    @Published var imageData: [String : Data] = [:]
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    
    let dataService: DessertsDataServiceProrocol
    let cacheService: CacheServiceProtocol
    
    init(dataService: DessertsDataServiceProrocol, cacheService: CacheServiceProtocol) {
        self.dataService = dataService
        self.cacheService = cacheService
    }
    
    func fetchAllCocktails() async {
        do {
            let drinks = try await dataService.fetchAllCocktails()
            await MainActor.run {
                self.AllDrinks = drinks
            }
        } catch {
            print(error.localizedDescription)
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
