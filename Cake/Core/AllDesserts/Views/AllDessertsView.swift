//
//  ContentView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI


struct AllDessertsView: View {
    
    
    @StateObject var viewModel = AllDessertsViewModel(dataService: DessertsDataService(), cacheService: CacheService())
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.filteredDesserts.isEmpty {
                    ContentUnavailableView("No Desserts Found", systemImage: "exclamationmark.magnifyingglass")
                }
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.filteredDesserts) { dessert in
                        if let cacheData = viewModel.cacheService.getImage(thumbURL: dessert.mealThumb) {
                            NavigationLink {
                                DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.id, imageData: cacheData as Data)
                            } label: {
                                DessertRowView(dessert: dessert, imageData: cacheData as Data)
                            }
                        }
                        else {
                            NavigationLink {
                                DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.id, imageData: viewModel.imageData[dessert.mealThumb] ?? nil)
                            } label: {
                                DessertRowView(dessert: dessert, imageData: viewModel.imageData[dessert.mealThumb] ?? nil )
                            }
                            .task {
                                await viewModel.getImageData(thumbURL: dessert.mealThumb)
                            }
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
            .onChange(of: viewModel.selectedCategory, { oldValue, newValue in
                Task {
                    await viewModel.fetchDesserts(category: newValue)
                }
            })
            .task {
                await viewModel.fetchDesserts(category: viewModel.selectedCategory)
                await viewModel.fetchCategories()
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
            .navigationTitle(viewModel.selectedCategory)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker(selection: $viewModel.selectedCategory) {
                            ForEach(viewModel.categories, id: \.idCategory) { category in
                                Text(category.category)
                                    .tag(category.category)
                            }
                        } label: {
                            
                        }

                    }
                label: {
                    HStack {
                        Text("Categories")
                    }
                }
                }
            })
        }
        
        .searchable(text: $viewModel.filterString)
    }
}

#Preview {
    AllDessertsView()
}

