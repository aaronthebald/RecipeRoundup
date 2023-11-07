//
//  DessertRowView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI

struct DessertRowView: View {
    
    let dessert: Dessert
    
    var body: some View {
        HStack(alignment: .bottom) {
            AsyncImage(url: URL(string: dessert.strMealThumb)) { Image in
                Image
                    .resizable()
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
            }
            Text(dessert.strMeal)
                .font(.title2)
        }
        .padding(.horizontal, 4)
    }
}

