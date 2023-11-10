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
                        // creating Image here to be passed into dependent views
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
            .alert("Error", isPresented: $viewModel.showAlert, actions: {
                Button {
                    viewModel.showAlert = false
                } label: {
                    Text("Dismiss")
                }

            }, message: {
                Text(viewModel.errorMessage ?? "")
            })
            .navigationTitle("All Desserts")
        }
        
    }
}

#Preview {
    AllDessertsView()
}
