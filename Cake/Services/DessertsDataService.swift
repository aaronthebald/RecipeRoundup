//
//  NetworkingManager.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import Foundation
import Combine

protocol DessertsDataServiceProrocol {
    var desserts: [Dessert] { get set }
    var dessertDetails: DessertDetailsModel? { get set }
    var errorMessage: String? { get set }
    
    func fetchAllDesserts(category: String) async throws -> [Dessert]
    func fetchDessertDetails(mealID: String, isCocktail: Bool) async throws -> Details
    func getImageData(thumbnailURL: String) async throws -> Data 
    func fetchAllCatagories() async throws -> [Category]
    func fetchAllCocktails() async throws -> [Drink]
}

class DessertsDataService: ObservableObject, DessertsDataServiceProrocol {
   
    @Published var desserts: [Dessert] = []
    @Published var dessertDetails: DessertDetailsModel?
    @Published var errorMessage: String?
    
    let allMealCatagories = "https://themealdb.com/api/json/v1/\(mealAPIKey)/categories.php"
    let allDessertsURLString = "https://themealdb.com/api/json/v1/\(mealAPIKey)/filter.php?c="
    let dessertDetailsString = "https://themealdb.com/api/json/v1/\(mealAPIKey)/lookup.php?i="
    
    let allCocktailsString = "https://thecocktaildb.com/api/json/v1/\(cocktailAPIKey)/filter.php?c=Cocktail"
    let cocktailDetailsString = "https://thecocktaildb.com/api/json/v1/\(cocktailAPIKey)/lookup.php?i="
    
    var cancellables = Set<AnyCancellable>()
    
    enum DataServiceError: Error {
        case badURL, badResponse, invalidURL, decodingError
    }
    
    func fetchAllCocktails() async throws -> [Drink] {
        guard let url = URL(string: allCocktailsString) else {  throw DataServiceError.invalidURL }
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
    
    func fetchAllCatagories() async throws -> [Category] {
        guard let url = URL(string: allMealCatagories) else {  throw DataServiceError.invalidURL }
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
    
    func fetchAllDesserts(category: String) async throws -> [Dessert] {
        guard let url = URL(string: allDessertsURLString + category) else {  throw DataServiceError.invalidURL }
        var dessetsArray: [Dessert] = []
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw DataServiceError.badResponse
            }
            let decodedData = try JSONDecoder().decode(AllDessertsResponse.self, from: data)
            dessetsArray = decodedData.meals
        } catch {
            throw error
        }
        return dessetsArray
    }
    
    func fetchDessertDetails(mealID: String, isCocktail: Bool) async throws -> Details {
        guard let url = URL(string: isCocktail ? cocktailDetailsString + mealID : dessertDetailsString + mealID) else { throw DataServiceError.badURL}
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

