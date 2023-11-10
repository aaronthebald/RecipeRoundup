//
//  IngredientListView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import SwiftUI

struct IngredientListView: View {
    let dessert: DessertDetailsModel
    // this view lays out the ingredients into a way that is easier to read.
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                itemsSectionOne
                itemSectionThree
            }
            .padding(.horizontal, 2)
            Spacer()
            VStack(alignment: .leading) {
                itemSectionTwo
                itemsectionFour
            }
            .padding(.horizontal, 2)
        }
        .font(.subheadline)
    }
    
    var itemsSectionOne: some View {
        VStack(alignment: .leading) {
            if dessert.strIngredient1 != "" && dessert.strIngredient1 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure1 ?? "There was an error")
                    Text(dessert.strIngredient1 ?? "There was an error")
                }
            }
            if dessert.strIngredient2 != "" && dessert.strIngredient2 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure2 ?? "There was an error")
                    Text(dessert.strIngredient2 ?? "There was an error")
                }
            }
            if dessert.strIngredient3 != "" && dessert.strIngredient3 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure3 ?? "There was an error")
                    Text(dessert.strIngredient3 ?? "There was an error")
                }
            }
            if dessert.strIngredient4 != "" && dessert.strIngredient4 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure4 ?? "There was an error")
                    Text(dessert.strIngredient4 ?? "There was an error")
                }
            }
            if dessert.strIngredient5 != "" && dessert.strIngredient5 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure5 ?? "There was an error")
                    Text(dessert.strIngredient5 ?? "There was an error")
                }
            }
        }
    }
    
    var itemSectionTwo: some View {
        VStack(alignment: .leading) {
            if dessert.strIngredient6 != "" && dessert.strIngredient6 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure6 ?? "There was an error")
                    Text(dessert.strIngredient6 ?? "There was an error")
                }
            }
            if dessert.strIngredient7 != "" && dessert.strIngredient7 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure7 ?? "There was an error")
                    Text(dessert.strIngredient7 ?? "There was an error")
                }
            }
            if dessert.strIngredient8 != "" && dessert.strIngredient8 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure8 ?? "There was an error")
                    Text(dessert.strIngredient8 ?? "There was an error")
                }
            }
            if dessert.strIngredient9 != "" && dessert.strIngredient9 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure9 ?? "There was an error")
                    Text(dessert.strIngredient9 ?? "There was an error")
                }
            }
            if dessert.strIngredient10 != "" && dessert.strIngredient10 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure10 ?? "There was an error")
                    Text(dessert.strIngredient10 ?? "There was an error")
                }
            }
        }
    }
    
    var itemSectionThree: some View {
        VStack(alignment: .leading) {
            if dessert.strIngredient11 != "" && dessert.strIngredient11 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure11 ?? "There was an error")
                    Text(dessert.strIngredient11 ?? "There was an error")
                }
            }
            if dessert.strIngredient12 != "" && dessert.strIngredient12 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure12 ?? "There was an error")
                    Text(dessert.strIngredient12 ?? "There was an error")
                }
            }
            if dessert.strIngredient13 != "" && dessert.strIngredient13 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure13 ?? "There was an error")
                    Text(dessert.strIngredient13 ?? "There was an error")
                }
            }
            if dessert.strIngredient14 != "" && dessert.strIngredient14 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure14 ?? "There was an error")
                    Text(dessert.strIngredient14 ?? "There was an error")
                }
            }
            if dessert.strIngredient15 != "" && dessert.strIngredient15 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure15 ?? "There was an error")
                    Text(dessert.strIngredient15 ?? "There was an error")
                }
            }
        }
    }
    
    var itemsectionFour: some View {
        VStack(alignment: .leading) {
            if dessert.strIngredient16 != "" && dessert.strIngredient16 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure16 ?? "There was an error")
                    Text(dessert.strIngredient16 ?? "There was an error")
                }
            }
            if dessert.strIngredient17 != "" && dessert.strIngredient17 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure17 ?? "There was an error")
                    Text(dessert.strIngredient17 ?? "There was an error")
                }
            }
            if dessert.strIngredient18 != "" && dessert.strIngredient18 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure18 ?? "There was an error")
                    Text(dessert.strIngredient18 ?? "There was an error")
                }
            }
            if dessert.strIngredient19 != "" && dessert.strIngredient19 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure19 ?? "There was an error")
                    Text(dessert.strIngredient19 ?? "There was an error")
                }
            }
            if dessert.strIngredient20 != "" && dessert.strIngredient20 != nil {
                HStack(alignment:.top) {
                    Text(dessert.strMeasure20 ?? "There was an error")
                    Text(dessert.strIngredient20 ?? "There was an error")
                }
            }
        }
    }
}


