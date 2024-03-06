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
class MockDessertsDataService: DessertsDataServiceProrocol, Mockable {
    func getImageData(thumbnailURL: String) async throws -> Data {
        let image = UIImage(named: "stockImage")
        let data = image!.jpegData(compressionQuality: 1.0)
        return data!
    }
    
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

class MockDessertsDataServiceError: DessertsDataServiceProrocol, Mockable {
    func getImageData(thumbnailURL: String) async throws -> Data {
        let error = DataServiceError.decodingError
        throw error
    }
    
    enum DataServiceError: Error {
        case badURL, badResponse, invalidURL, decodingError
    }
    var desserts: [Cake.Dessert] = []
    
    var dessertDetails: Cake.DessertDetailsModel?
    
    var errorMessage: String?
    
    func fetchAllDesserts() async throws -> [Cake.Dessert] {
        let error = DataServiceError.badResponse
        throw error
    }
    
    func fetchDessertDetails(mealID: String) async throws -> Cake.DessertDetailsModel {
        let error = DataServiceError.badResponse
        throw error
    }
    
    
}
