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

struct Dessert: Codable, Identifiable, Equatable, FoodDrink {
    
    var name: String
    var thumb: String
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumb = "strMealThumb"
        case id = "idMeal"
    }
}
