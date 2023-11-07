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

struct Dessert: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
