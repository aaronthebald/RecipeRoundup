//
//  MockDessertsDataService.swift
//  CakeTests
//
//  Created by Aaron Wilson on 11/16/23.
//

import Foundation
@testable import Cake
class MockDessertsDataService: DessertsDataServiceProrocol, Mockable {
    enum DataServiceError: Error {
        case badURL, badResponse, invalidURL, decodingError
    }
    var desserts: [Cake.Dessert] = []
    
    var dessertDetails: Cake.DessertDetailsModel?
    
    var errorMessage: String?
    
    func fetchAllDesserts() async throws -> [Dessert] {
        let response = loadJSON(filename: "AllDessertsResponse", type: AllDessertsResponse.self)
        return response.meals
    }
    
    func fetchDessertDetails(mealID: String) async throws -> DessertDetailsModel {
        let response = loadJSON(filename: "DessertDetailsResponse", type: DessertDetailsResponseModel.self)
        guard let details = response.meals.first else { throw DataServiceError.decodingError }
        return details
    }
}
