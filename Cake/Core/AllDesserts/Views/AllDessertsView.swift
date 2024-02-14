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
                    ForEach(viewModel.filteredDesserts, id: \.id) { dessert in
                        if let cacheData = viewModel.cacheService.getImage(thumbURL: dessert.thumb) {
                            NavigationLink {
                                DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.id, imageData: cacheData as Data, isCocktail: viewModel.isCocktail)
                            } label: {
                                DessertRowView(dessert: dessert.name, imageData: cacheData as Data)
                            }
                        }
                        else {
                            NavigationLink {
                                DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.id, imageData: viewModel.imageData[dessert.thumb] ?? nil, isCocktail: viewModel.isCocktail)
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
                    await viewModel.fetchDesserts(category: newValue)
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
            .navigationTitle(viewModel.isCocktail ? "Cocktails" : viewModel.selectedCategory)
            .toolbar(content: {
                if !viewModel.isCocktail {
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
                }
                
                
                ToolbarItem {
                    Button {
                        if viewModel.isCocktail {
                            viewModel.isCocktail = false
                            Task {
                                await viewModel.fetchDesserts(category: viewModel.selectedCategory)
                            }
                        } else {
                            viewModel.isCocktail = true
                            Task {
                                await viewModel.fetchAllCocktails()
                            }
                        }
                    } label: {
                        if viewModel.isCocktail {
                            Text("Food")
                        } else {
                            Text("Cocktails")
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

