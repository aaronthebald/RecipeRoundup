//
//  AllDessertsResponse.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import Foundation

struct AllDessertsResponse: Codable {
    let meals: [Dessert]
}

struct Dessert: Codable, Identifiable {
    
    let meal: String
    let mealThumb: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case meal = "strMeal"
        case mealThumb = "strMealThumb"
        case id = "idMeal"
    }
}
