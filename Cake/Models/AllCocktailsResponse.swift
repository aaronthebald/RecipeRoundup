//
//  AllCocktailsResponse.swift
//  Cake
//
//  Created by Aaron Wilson on 2/4/24.
//

import Foundation

protocol FoodDrink {
    var name: String { get set }
    var thumb: String { get set }
    var id: String { get set }
}

struct AllCocktailsResponse: Codable {
    let drinks: [Drink]
}

struct Drink: Codable, FoodDrink, Identifiable {
    var name: String
    var thumb: String
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case thumb = "strDrinkThumb"
        case id = "idDrink"
    }
}
