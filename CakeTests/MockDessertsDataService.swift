//
//  MockDessertsDataService.swift
//  CakeTests
//
//  Created by Aaron Wilson on 11/16/23.
//

import Foundation
import SwiftUI
// Tests were written for older version of the app. Will return to rewrite test suite.
@testable import Cake
class MockDessertsDataService: DataServiceProtocol, Mockable {
    
    
    
    func getImageData(thumbnailURL: String) async throws -> Data {
        let image = UIImage(named: "stockImage")
        let data = image!.jpegData(compressionQuality: 1.0)
        return data!
    }
    
    enum DataServiceError: Error {
        case badURL, badResponse, invalidURL, decodingError
    }
    var items: [FoodDrinkItem] = []
    
    var itemDetails: Cake.ItemDetailsModel?
    
    var errorMessage: String?
    
    func fetchItems(category: String) async throws -> [Cake.FoodDrinkItem] {
        let response = loadJSON(filename: "AllDessertsResponse", type: AllDessertsResponse.self)
        return response.meals
    }
    
    func fetchItemDetails(mealID: String, isCocktail: Bool) async throws -> any Cake.Details {
        let response = loadJSON(filename: "DessertDetailsResponse", type: DessertDetailsResponseModel.self)
        guard let details = response.items.first else { throw DataServiceError.decodingError }
        return details
    }
    
    func fetchAllCategories() async throws -> [Cake.Category] {
        return []
    }
    
    func fetchAllCocktails() async throws -> [Cake.Drink] {
        return []
    }

}

class MockDessertsDataServiceError: DataServiceProtocol, Mockable {
    
    
    
    enum DataServiceError: Error {
        case badURL, badResponse, invalidURL, decodingError
    }
    var items: [FoodDrinkItem] = []
    
    var itemDetails: Cake.ItemDetailsModel?
    
    var errorMessage: String?
    
    func fetchItems(category: String) async throws -> [Cake.FoodDrinkItem] {
        let error = DataServiceError.badResponse
        throw error
    }
    
    func fetchItemDetails(mealID: String, isCocktail: Bool) async throws -> any Cake.Details {
        let error = DataServiceError.badResponse
        throw error
    }
    
    func fetchAllCategories() async throws -> [Cake.Category] {
        return []
    }
    
    func fetchAllCocktails() async throws -> [Cake.Drink] {
       return []
    }
    
    func getImageData(thumbnailURL: String) async throws -> Data {
        let error = DataServiceError.decodingError
        throw error
    }
    
}
