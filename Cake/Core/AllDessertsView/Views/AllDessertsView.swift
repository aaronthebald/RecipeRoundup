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
                        let image = QuickImage(url: URL(string: dessert.strMealThumb))
                        NavigationLink {
                            DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.idMeal, image: image)
                        } label: {
                            DessertRowView(dessert: dessert, image: image)
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
