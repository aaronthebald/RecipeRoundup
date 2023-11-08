//
//  IngredientListView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import SwiftUI

struct IngredientListView: View {
    let dessert: DessertDetailsModel
    var body: some View {
        VStack(alignment: .leading) {
            if dessert.strIngredient1 != "" {
                HStack {
                    Text(dessert.strMeasure1)
                    Text(dessert.strIngredient1)
                }
            }
            if dessert.strIngredient2 != "" {
                HStack {
                    Text(dessert.strMeasure2)
                    Text(dessert.strIngredient2)
                }
            }
            if dessert.strIngredient3 != "" {
                HStack {
                    Text(dessert.strMeasure3)
                    Text(dessert.strIngredient3)
                }
            }
            if dessert.strIngredient4 != "" {
                HStack {
                    Text(dessert.strMeasure4)
                    Text(dessert.strIngredient4)
                }
            }
            if dessert.strIngredient5 != "" {
                HStack {
                    Text(dessert.strMeasure5)
                    Text(dessert.strIngredient5)
                }
            }
            if dessert.strIngredient6 != "" {
                HStack {
                    Text(dessert.strMeasure6)
                    Text(dessert.strIngredient6)
                }
            }
            if dessert.strIngredient7 != "" {
                HStack {
                    Text(dessert.strMeasure7)
                    Text(dessert.strIngredient7)
                }
            }
            if dessert.strIngredient8 != "" {
                HStack {
                    Text(dessert.strMeasure8)
                    Text(dessert.strIngredient8)
                }
            }
            if dessert.strIngredient9 != "" {
                HStack {
                    Text(dessert.strMeasure9)
                    Text(dessert.strIngredient9)
                }
            }
            if dessert.strIngredient10 != "" {
                HStack {
                    Text(dessert.strMeasure10)
                    Text(dessert.strIngredient10)
                }
            }
            if dessert.strIngredient11 != "" {
                HStack {
                    Text(dessert.strMeasure11)
                    Text(dessert.strIngredient11)
                }
            }
            if dessert.strIngredient12 != "" {
                HStack {
                    Text(dessert.strMeasure12)
                    Text(dessert.strIngredient12)
                }
            }
            if dessert.strIngredient13 != "" {
                HStack {
                    Text(dessert.strMeasure13)
                    Text(dessert.strIngredient13)
                }
            }
            if dessert.strIngredient14 != "" {
                HStack {
                    Text(dessert.strMeasure14)
                    Text(dessert.strIngredient14)
                }
            }
            if dessert.strIngredient15 != "" {
                HStack {
                    Text(dessert.strMeasure15)
                    Text(dessert.strIngredient15)
                }
            }
            if dessert.strIngredient16 != "" {
                HStack {
                    Text(dessert.strMeasure16)
                    Text(dessert.strIngredient16)
                }
            }
            if dessert.strIngredient17 != "" {
                HStack {
                    Text(dessert.strMeasure17)
                    Text(dessert.strIngredient17)
                }
            }
            if dessert.strIngredient18 != "" {
                HStack {
                    Text(dessert.strMeasure18)
                    Text(dessert.strIngredient18)
                }
            }
            if dessert.strIngredient19 != "" {
                HStack {
                    Text(dessert.strMeasure19)
                    Text(dessert.strIngredient19)
                }
            }
            if dessert.strIngredient20 != "" {
                HStack {
                    Text(dessert.strMeasure20)
                    Text(dessert.strIngredient20)
                }
            }
        }
        .font(.caption)
    }
}


