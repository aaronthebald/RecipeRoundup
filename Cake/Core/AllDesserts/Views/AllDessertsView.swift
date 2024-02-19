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
                    ContentUnavailableView("No Items Found", systemImage: "exclamationmark.magnifyingglass")
                }
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.showFavorites ? viewModel.favoriteItems : viewModel.filteredDesserts, id: \.id) { dessert in
                        if let cacheData = viewModel.cacheService.getImage(thumbURL: dessert.thumb) {
                            NavigationLink {
                                DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.id, imageData: cacheData as Data, isCocktail: viewModel.isCocktail, favoriteService: viewModel.favoriteService)
                            } label: {
                                DessertRowView(dessert: dessert.name, imageData: cacheData as Data)
                            }
                        }
                        else {
                            NavigationLink {
                                DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.id, imageData: viewModel.imageData[dessert.thumb] ?? nil, isCocktail: viewModel.isCocktail, favoriteService: viewModel.favoriteService)
                            } label: {
                                DessertRowView(dessert: dessert.name, imageData: viewModel.imageData[dessert.thumb] ?? nil )
                            }
                            .task {
                                await viewModel.getImageData(thumbURL: dessert.thumb)
                            }
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
            .onChange(of: viewModel.selectedCategory, { oldValue, newValue in
                Task {
                    if newValue != "" {
                        viewModel.isCocktail = false
                        await viewModel.fetchDesserts(category: newValue)
                    }
                }
            })
            .alert("Error", isPresented: $viewModel.showAlert, actions: {
                Button {
                    viewModel.showAlert = false
                } label: {
                    Text("Dismiss")
                }
                
            }, message: {
                Text(viewModel.errorMessage ?? "")
            })
            .navigationTitle(viewModel.showFavorites ? "Favorites" : viewModel.isCocktail ? "Cocktails" : viewModel.selectedCategory)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button {
                            viewModel.isCocktail = true
                            Task {
                                await viewModel.fetchAllCocktails()
                                viewModel.selectedCategory = ""
                            }
                        } label: {
                            Text("Cocktails")
                        }
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
                
                
                ToolbarItem {
                    Button {
                        viewModel.showFavorites.toggle()
                    } label: {
                        if viewModel.showFavorites {
                            Text("Show all items")
                        } else {
                            Text("Show favorites")
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

