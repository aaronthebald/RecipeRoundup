//
//  ContentView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI


struct AllDessertsView: View {
    
    
    @StateObject var viewModel = AllDessertsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.desserts) { dessert in
                        // creating Image here to be passed into dependent views
                        let image = QuickAsyncImage(url: URL(string: dessert.mealThumb))
                        NavigationLink {
                            DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.id, image: image)
                        } label: {
                            DessertRowView(dessert: dessert, image: image)
                                .overlay {
                                    if viewModel.loadingBuffer {
                                        Rectangle()
                                            .fill(.ultraThinMaterial)
                                    }
                                }
                        }
                        .disabled(viewModel.loadingBuffer)
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
