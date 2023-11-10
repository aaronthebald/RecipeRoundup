//
//  DessertDetailsModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import Foundation
/*
 {
     "meals": [
         {
             "idMeal": "52909",
             "strMeal": "Tarte Tatin",
             "strDrinkAlternate": null,
             "strCategory": "Dessert",
             "strArea": "French",
             "strInstructions": "Roll the pastry to a 3mm-thick round on a lightly floured surface and cut a 24cm circle, using a plate as a guide. Lightly prick all over with a fork, wrap in cling film on a baking sheet and freeze while preparing the apples.\r\nHeat oven to 180C/160C fan/gas 4. Peel, quarter and core the apples. Put the sugar in a flameproof 20cm ceramic Tatin dish or a 20cm ovenproof heavy-based frying pan and place over a medium-high heat. Cook the sugar for 5-7 mins to a dark amber caramel syrup that’s starting to smoke, then turn off the heat and stir in the 60g diced chilled butter.\r\nTo assemble the Tarte Tatin, arrange the apple quarters very tightly in a circle around the edge of the dish first, rounded-side down, then fill in the middle in a similar fashion. Gently press with your hands to ensure there are no gaps. Brush the fruit with the melted butter.\r\nBake in the oven for 30 mins, then remove and place the disc of frozen puff pastry on top – it will quickly defrost. Tuck the edges down the inside of the dish and, with a knife, prick a few holes in the pastry to allow steam to escape. Bake for a further 40-45 mins until the pastry is golden brown and crisp.\r\nAllow to cool to room temperature for 1 hr before running a knife around the edge of the dish and inverting it onto a large serving plate that is deep enough to contain the juices. Serve with crème fraîche or vanilla ice cream.",
             "strMealThumb": "https://www.themealdb.com/images/media/meals/ryspuw1511786688.jpg",
             "strTags": "Treat,Tart,Desert,DinnerParty",
             "strYoutube": "https://www.youtube.com/watch?v=8xDM8U6h9Pw",
             "strIngredient1": "Puff Pastry",
             "strIngredient2": "Plain Flour",
             "strIngredient3": "Braeburn Apples",
             "strIngredient4": "Caster Sugar",
             "strIngredient5": "Butter",
             "strIngredient6": "Creme Fraiche",
             "strIngredient7": "",
             "strIngredient8": "",
             "strIngredient9": "",
             "strIngredient10": "",
             "strIngredient11": "",
             "strIngredient12": "",
             "strIngredient13": "",
             "strIngredient14": "",
             "strIngredient15": "",
             "strIngredient16": "",
             "strIngredient17": "",
             "strIngredient18": "",
             "strIngredient19": "",
             "strIngredient20": "",
             "strMeasure1": "300g",
             "strMeasure2": "Dusting",
             "strMeasure3": "6",
             "strMeasure4": "100g ",
             "strMeasure5": "85g",
             "strMeasure6": "to serve",
             "strMeasure7": "",
             "strMeasure8": "",
             "strMeasure9": "",
             "strMeasure10": "",
             "strMeasure11": "",
             "strMeasure12": "",
             "strMeasure13": "",
             "strMeasure14": "",
             "strMeasure15": "",
             "strMeasure16": "",
             "strMeasure17": "",
             "strMeasure18": "",
             "strMeasure19": "",
             "strMeasure20": "",
             "strSource": "https://www.bbcgoodfood.com/recipes/tarte-tatin",
             "strImageSource": null,
             "strCreativeCommonsConfirmed": null,
             "dateModified": null
         }
     ]
 }
 */

struct DessertDetailsResponseModel: Codable {
    let meals: [DessertDetailsModel]
}
// TODO: make values optional
struct DessertDetailsModel: Codable {
    
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String
    let strYoutube: String?
    let strTags: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
}
