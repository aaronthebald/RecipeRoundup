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

struct DessertDetailsModel: Codable, Equatable {
    
    let id: String
    let meal: String
    let drinkAlternate: String?
    let category: String?
    let area: String?
    let instructions: String?
    let mealThumb: String
    let youtube: String?
    let tags: String?
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    let ingredient8: String?
    let ingredient9: String?
    let ingredient10: String?
    let ingredient11: String?
    let ingredient12: String?
    let ingredient13: String?
    let ingredient14: String?
    let ingredient15: String?
    let ingredient16: String?
    let ingredient17: String?
    let ingredient18: String?
    let ingredient19: String?
    let ingredient20: String?
    let measure1: String?
    let measure2: String?
    let measure3: String?
    let measure4: String?
    let measure5: String?
    let measure6: String?
    let measure7: String?
    let measure8: String?
    let measure9: String?
    let measure10: String?
    let measure11: String?
    let measure12: String?
    let measure13: String?
    let measure14: String?
    let measure15: String?
    let measure16: String?
    let measure17: String?
    let measure18: String?
    let measure19: String?
    let measure20: String?
    let source: String?
    let imageSource: String?
    let creativeCommonsConfirmed: String?
    let dateModified: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case meal = "strMeal"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case mealThumb = "strMealThumb"
        case youtube = "strYoutube"
        case tags = "strTags"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
        case source = "strSource"
        case imageSource = "strImageSource"
        case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModified = "dateModified"
    }

    var sectionOne: [IngredientMeasurement] {
        [
            IngredientMeasurement(ingredient: ingredient1, measurement: measure1),
            IngredientMeasurement(ingredient: ingredient2, measurement: measure2),
            IngredientMeasurement(ingredient: ingredient3, measurement: measure3),
            IngredientMeasurement(ingredient: ingredient4, measurement: measure4),
            IngredientMeasurement(ingredient: ingredient5, measurement: measure5),
        ]
            .compactMap { $0 }
    }
    
    var sectionTwo: [IngredientMeasurement] {
        [
            IngredientMeasurement(ingredient: ingredient6, measurement: measure6),
            IngredientMeasurement(ingredient: ingredient7, measurement: measure7),
            IngredientMeasurement(ingredient: ingredient8, measurement: measure8),
            IngredientMeasurement(ingredient: ingredient9, measurement: measure9),
            IngredientMeasurement(ingredient: ingredient10, measurement: measure10),
        ]
            .compactMap { $0 }
    }
    
    var sectionThree: [IngredientMeasurement] {
        [
            IngredientMeasurement(ingredient: ingredient11, measurement: measure11),
            IngredientMeasurement(ingredient: ingredient12, measurement: measure12),
            IngredientMeasurement(ingredient: ingredient13, measurement: measure13),
            IngredientMeasurement(ingredient: ingredient14, measurement: measure14),
            IngredientMeasurement(ingredient: ingredient15, measurement: measure15),
        ]
            .compactMap { $0 }
    }
    var sectionFour: [IngredientMeasurement] {
        [
            IngredientMeasurement(ingredient: ingredient16, measurement: measure16),
            IngredientMeasurement(ingredient: ingredient17, measurement: measure17),
            IngredientMeasurement(ingredient: ingredient18, measurement: measure18),
            IngredientMeasurement(ingredient: ingredient19, measurement: measure19),
            IngredientMeasurement(ingredient: ingredient20, measurement: measure20),
        ]
            .compactMap { $0 }
    }
    
    
    struct IngredientMeasurement: Hashable, Identifiable {
        let id = UUID()
        let ingredient: String
        let measurement: String
        
        init?(ingredient: String?, measurement: String?) {
            if let ingredient,
               let measurement,
               !ingredient.isEmpty,
               !measurement.isEmpty {
                self.ingredient = ingredient
                self.measurement = measurement
            } else {
                return nil
            }
        }
    }
    
    static let placeholderDetails = DessertDetailsModel(id: "", meal: "", drinkAlternate: "", category: "", area: "", instructions: "", mealThumb: "", youtube: "", tags: "", ingredient1: "", ingredient2: "", ingredient3: "", ingredient4: "", ingredient5: "", ingredient6: "", ingredient7: "", ingredient8: "", ingredient9: "", ingredient10: "", ingredient11: "", ingredient12: "", ingredient13: "", ingredient14: "", ingredient15: "", ingredient16: "", ingredient17: "", ingredient18: "", ingredient19: "", ingredient20: "", measure1: "", measure2: "", measure3: "", measure4: "", measure5: "", measure6: "", measure7: "", measure8: "", measure9: "", measure10: "", measure11: "", measure12: "", measure13: "", measure14: "", measure15: "", measure16: "", measure17: "", measure18: "", measure19: "", measure20: "", source: "", imageSource: "", creativeCommonsConfirmed: "", dateModified: "")
}
