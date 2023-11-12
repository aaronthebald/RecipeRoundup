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
                itemSectionFour
            }
            .padding(.horizontal, 2)
        }
        .font(.subheadline)
    }
    
    var itemsSectionOne: some View {
        VStack(alignment: .leading) {
            ForEach(dessert.sectionOne) { item in
                HStack(alignment:.top) {
                    Text(item.measurement)
                    Text(item.ingredient)
                }
            }
        }
    }
    
    var itemSectionTwo: some View {
        VStack(alignment: .leading) {
            ForEach(dessert.sectionTwo) { item in
                HStack(alignment:.top) {
                    Text(item.measurement)
                    Text(item.ingredient)
                }
            }
        }
    }
    
    var itemSectionThree: some View {
        VStack(alignment: .leading) {
            ForEach(dessert.sectionThree) { item in
                HStack(alignment: .top) {
                    Text(item.measurement)
                    Text(item.ingredient)
                }
            }
        }
    }
    
    var itemSectionFour: some View {
        VStack(alignment: .leading) {
            ForEach(dessert.sectionFour) { item in
                HStack(alignment: .top) {
                    Text(item.measurement)
                    Text(item.ingredient)
                }
            }
        }
    }
}


