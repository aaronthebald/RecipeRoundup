//
//  DessertsDataService.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import Foundation
import Combine

protocol DataServiceProtocol {
    var items: [FoodDrinkItem] { get set }
    var itemDetails: ItemDetailsModel? { get set }
    var errorMessage: String? { get set }
    
    func fetchItems(category: String) async throws -> [FoodDrinkItem]
    func fetchItemDetails(mealID: String, isCocktail: Bool) async throws -> Details
    func getImageData(thumbnailURL: String) async throws -> Data 
    func fetchAllCategories() async throws -> [Category]
    func fetchAllCocktails() async throws -> [Drink]
}

class DataService: ObservableObject, DataServiceProtocol {
   
    @Published var items: [FoodDrinkItem] = []
    @Published var itemDetails: ItemDetailsModel?
    @Published var errorMessage: String?
    
    let allMealCategories = "https://themealdb.com/api/json/v1/1/categories.php"
    let listOfItemsURLString = "https://themealdb.com/api/json/v1/1/filter.php?c="
    let itemDetailsString = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    let allCocktailsString = "https://thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
    let cocktailDetailsString = "https://thecocktaildb.com/api/json/v1/1/lookup.php?i="
    
    var cancellables = Set<AnyCancellable>()
    
    enum DataServiceError: Error {
        case badURL, badResponse, invalidURL, decodingError
    }
    
    func fetchAllCocktails() async throws -> [Drink] {
        guard let url = URL(string: allCocktailsString) else { throw DataServiceError.invalidURL }
        var cocktails: [Drink] = []
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw DataServiceError.badResponse
            }
            let decodedData = try JSONDecoder().decode(AllCocktailsResponse.self, from: data)
            cocktails = decodedData.drinks
        } catch {
            throw error
        }
        return cocktails
    }
    
    func fetchAllCategories() async throws -> [Category] {
        guard let url = URL(string: allMealCategories) else { throw DataServiceError.invalidURL }
        var categories: [Category] = []
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw DataServiceError.badResponse
            }
            let decodedData = try JSONDecoder().decode(CategoryResponse.self, from: data)
            categories = decodedData.categories
        } catch {
            throw error
        }
        return categories
    }
    
    func fetchItems(category: String) async throws -> [FoodDrinkItem] {
        guard let url = URL(string: listOfItemsURLString + category) else { throw DataServiceError.invalidURL }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw DataServiceError.badResponse
            }
            let decodedData = try JSONDecoder().decode(AllDessertsResponse.self, from: data)
            return decodedData.meals
        } catch {
            throw error
        }
    }
    
    func fetchItemDetails(mealID: String, isCocktail: Bool) async throws -> Details {
        guard let url = URL(string: isCocktail ? cocktailDetailsString + mealID : itemDetailsString + mealID) else { throw DataServiceError.badURL}
        do {
            let (data, response) = try await  URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw DataServiceError.badResponse
            }
            switch isCocktail {
            case true:
                let details = try JSONDecoder().decode(CocktailsDetailsResponse.self, from: data)
                guard let dessertDetails = details.items.first else { throw DataServiceError.decodingError }
                return dessertDetails
            case false:
                let details = try JSONDecoder().decode(DessertDetailsResponseModel.self, from: data)
                guard let dessertDetails = details.items.first else { throw DataServiceError.decodingError }
                return dessertDetails
            }
        } catch {
            throw error
        }
    }
    
    func getImageData(thumbnailURL: String) async throws -> Data {
        guard let url = URL(string: thumbnailURL) else { throw DataServiceError.badURL }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }
}

