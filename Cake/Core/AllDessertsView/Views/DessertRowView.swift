//
//  DessertRowView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI

struct DessertRowView: View {
    
    let dessert: Dessert
    let image: QuickImage
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                image
                    .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(dessert.strMeal)
                    .font(.title2)
                    .tint(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .tint(.primary)
            }
            Divider()
        }
       
    }
}

