//
//  AllCocktailsResponse.swift
//  Cake
//
//  Created by Aaron Wilson on 2/4/24.
//

import Foundation

protocol FoodDrink {
    var name: String { get }
    var thumb: String { get }
    var id: String { get }
    var isCocktail: Bool { get }
}

struct AllCocktailsResponse: Codable {
    let drinks: [Drink]
}

struct Drink: Codable, FoodDrink, Identifiable {
    let name: String
    let thumb: String
    let id: String
    let isCocktail: Bool = true
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case thumb = "strDrinkThumb"
        case id = "idDrink"
    }
}
