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
    
    // because it's not common to use `str` in front of variable names you could use CodingKeys, and make this conform to `Identifiable`, which will make it so that on the `AllDessertsView` you don't need `id: \.idMeal` on the ForEach loop
    
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
