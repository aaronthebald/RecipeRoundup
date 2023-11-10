//
//  ContentView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI

struct AllDessertsView: View {
    
    @StateObject var viewModel: AllDessertsViewModel = AllDessertsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.sortedDesserts, id: \.idMeal) { dessert in
                        NavigationLink {
                            DessertDetailsView(mealId: dessert.idMeal)
                        } label: {
                            DessertRowView(dessert: dessert)
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
            .navigationTitle("All Desserts")
        }
        
    }
}

#Preview {
    AllDessertsView()
}
