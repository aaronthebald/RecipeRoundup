//
//  AllDessertsResponse.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import Foundation

struct AllDessertsResponse: Codable {
    let meals: [FoodDrinkItem]
}

struct FoodDrinkItem: Codable, Identifiable, Equatable, FoodDrink {
    
    let name: String
    let thumb: String
    let id: String
    let isCocktail: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumb = "strMealThumb"
        case id = "idMeal"
    }
}
