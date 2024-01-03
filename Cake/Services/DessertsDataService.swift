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
    
    func fetchAllDesserts() async throws -> [Dessert]
    func fetchDessertDetails(mealID: String) async throws -> DessertDetailsModel
    func getImageData(thumbnailURL: String) async throws -> Data 
}

class DessertsDataService: ObservableObject, DessertsDataServiceProrocol {
   
    @Published var desserts: [Dessert] = []
    @Published var dessertDetails: DessertDetailsModel?
    @Published var errorMessage: String?
    
    let allDessertsURLString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    let dessertDetailsString = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    var cancellables = Set<AnyCancellable>()
    
    enum DataServiceError: Error {
        case badURL, badResponse, invalidURL, decodingError
    }
    
    func fetchAllDesserts() async throws -> [Dessert] {
        guard let url = URL(string: allDessertsURLString) else {  throw DataServiceError.invalidURL }
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
    
    func fetchDessertDetails(mealID: String) async throws -> DessertDetailsModel {
        guard let url = URL(string: dessertDetailsString + mealID) else { throw DataServiceError.badURL}
        do {
            let (data, response) = try await  URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw DataServiceError.badResponse
            }
            let details = try JSONDecoder().decode(DessertDetailsResponseModel.self, from: data)
            guard let dessertDetails = details.meals.first else { throw DataServiceError.decodingError }
            return dessertDetails
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

