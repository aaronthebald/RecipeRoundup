//
//  CategoryResponse.swift
//  Cake
//
//  Created by Aaron Wilson on 2/4/24.
//

import Foundation

struct CategoryResponse: Codable {
    let categories: [Category]
}


struct Category: Codable {
    let idCategory, category: String
    let categoryThumb: String
    let categoryDescription: String
    
    enum CodingKeys: String, CodingKey {
        case idCategory
        case category = "strCategory"
        case categoryThumb = "strCategoryThumb"
        case categoryDescription = "strCategoryDescription"
    }
}
