//
//  DessertDetailsModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import Foundation

protocol Details: Codable {
    
    var id: String { get }
    var meal: String { get }
    var drinkAlternate: String? { get }
    var category: String? { get }
    var area: String? { get }
    var instructions: String? { get }
    var mealThumb: String { get }
    var youtube: String? { get }
    var tags: String? { get }
    var ingredient1: String? { get }
    var ingredient2: String? { get }
    var ingredient3: String? { get }
    var ingredient4: String? { get }
    var ingredient5: String? { get }
    var ingredient6: String? { get }
    var ingredient7: String? { get }
    var ingredient8: String? { get }
    var ingredient9: String? { get }
    var ingredient10: String? { get }
    var ingredient11: String? { get }
    var ingredient12: String? { get }
    var ingredient13: String? { get }
    var ingredient14: String? { get }
    var ingredient15: String? { get }
    var ingredient16: String? { get }
    var ingredient17: String? { get }
    var ingredient18: String? { get }
    var ingredient19: String? { get }
    var ingredient20: String? { get }
    var measure1: String? { get }
    var measure2: String? { get }
    var measure3: String? { get }
    var measure4: String? { get }
    var measure5: String? { get }
    var measure6: String? { get }
    var measure7: String? { get }
    var measure8: String? { get }
    var measure9: String? { get }
    var measure10: String? { get }
    var measure11: String? { get }
    var measure12: String? { get }
    var measure13: String? { get }
    var measure14: String? { get }
    var measure15: String? { get }
    var measure16: String? { get }
    var measure17: String? { get }
    var measure18: String? { get }
    var measure19: String? { get }
    var measure20: String? { get }
    var source: String? { get }
    var imageSource: String? { get }
    var creativeCommonsConfirmed: String? { get }
    var dateModified: String? { get }
    var sectionOne: [IngredientMeasurement] { get }
    var sectionTwo: [IngredientMeasurement] { get }
    var sectionThree: [IngredientMeasurement] { get }
    var sectionFour: [IngredientMeasurement] { get }
}



struct DessertDetailsResponseModel: Codable {
    
    var items: [ItemDetailsModel]
    enum CodingKeys: String, CodingKey {
    case items = "meals"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.items, forKey: .items)
    }
    
}

struct ItemDetailsModel: Codable, Equatable, Details {
    
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
    
    static let placeholderDetails = ItemDetailsModel(id: "", meal: "", drinkAlternate: "", category: "", area: "", instructions: "", mealThumb: "", youtube: "", tags: "", ingredient1: "", ingredient2: "", ingredient3: "", ingredient4: "", ingredient5: "", ingredient6: "", ingredient7: "", ingredient8: "", ingredient9: "", ingredient10: "", ingredient11: "", ingredient12: "", ingredient13: "", ingredient14: "", ingredient15: "", ingredient16: "", ingredient17: "", ingredient18: "", ingredient19: "", ingredient20: "", measure1: "", measure2: "", measure3: "", measure4: "", measure5: "", measure6: "", measure7: "", measure8: "", measure9: "", measure10: "", measure11: "", measure12: "", measure13: "", measure14: "", measure15: "", measure16: "", measure17: "", measure18: "", measure19: "", measure20: "", source: "", imageSource: "", creativeCommonsConfirmed: "", dateModified: "")
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
