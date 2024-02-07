//
//  AllCocktailsResponse.swift
//  Cake
//
//  Created by Aaron Wilson on 2/4/24.
//

import Foundation
struct AllCocktailsResponse: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let drink: String
    let drinkThumb: String
    let idDrink: String
    
    enum CodingKeys: String, CodingKey {
        case drink = "strDrink"
        case drinkThumb = "strDrinkThumb"
        case idDrink = "idDrink"
    }
}
