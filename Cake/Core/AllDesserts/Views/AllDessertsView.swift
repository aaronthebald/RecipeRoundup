//
//  AllDessertsView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI
import RevenueCat

struct AllDessertsView: View {
    
    @StateObject private var viewModel = AllDessertsViewModel(dataService: DataService(), cacheService: CacheService())
    @EnvironmentObject var proAccessManager: ProAccessManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.filteredItems.isEmpty && viewModel.viewIsLoading == false {
                    ContentUnavailableView("No Items Found", systemImage: "exclamationmark.magnifyingglass")
                } else if viewModel.showFavorites && viewModel.favoriteItems.isEmpty && viewModel.viewIsLoading == false {
                    emptyFavoritesView
                }
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.showFavorites ? viewModel.favoriteItems : viewModel.filteredItems, id: \.id) { dessert in
//                    This if statement checks to see if the needed data for the image of the item is currently in the cache. If it is not then a function is called to download the data and store it in the cache.
                        if let cacheData = viewModel.cacheService.getImage(thumbURL: dessert.thumb) {
                            NavigationLink {
                                DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.id, imageData: cacheData as Data, isCocktail: dessert.isCocktail, favoriteService: viewModel.favoriteService, proAccessManager: proAccessManager)
                            } label: {
                                DessertRowView(dessert: dessert.name, imageData: cacheData as Data)
                            }
                        }
                        else {
                            NavigationLink {
                                DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.id, imageData: viewModel.imageData[dessert.thumb] ?? nil, isCocktail: dessert.isCocktail, favoriteService: viewModel.favoriteService, proAccessManager: proAccessManager)
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
            .overlay(content: {
                if viewModel.viewIsLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .background(.ultraThinMaterial)
                        
                }
            })
            .onChange(of: viewModel.selectedCategory, { oldValue, newValue in
                Task {
                    if newValue != "" {
                        viewModel.showFavorites = false
                        viewModel.isCocktail = false
                        await viewModel.fetchDesserts(category: newValue)
                    } else {
                        viewModel.showFavorites = false
                        viewModel.isCocktail = true
                        await viewModel.fetchAllCocktails()
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
                            viewModel.showFavorites.toggle()
                        } label: {
                            Text("Favorites")
                        }
                        Button {
                            viewModel.isCocktail = true
                            Task {
                                await viewModel.fetchAllCocktails()
                                viewModel.selectedCategory = ""
                            }
                        } label: {
                            Text("Cocktails")
                        }
                        Menu {
                            Picker(selection: $viewModel.selectedCategory) {
                                ForEach(viewModel.categories, id: \.idCategory) { category in
                                    Text(category.category)
                                        .tag(category.category)
                                }
                            } label: {
                                
                            }
                        } label: {
                            Text("Food Categories")
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
                        viewModel.showSettingSheet = true
                    } label: {
                        Image(systemName: "gear")
                    }

                }
            })
            .sheet(isPresented: $viewModel.showSettingSheet, content: {
                SettingsView(proAccessManager: proAccessManager)
            })
        }
        .onAppear(perform: {
            Purchases.shared.getCustomerInfo { info, error in
                if info?.entitlements["proaccess"]?.isActive == true {
                    print("pro access checked")
                    self.proAccessManager.isProAccess = true
                }
            }
        })
        .searchable(text: $viewModel.filterString, prompt: "Search within category")
    }
}

#Preview {
    AllDessertsView()
}

extension AllDessertsView {
    
    private var emptyFavoritesView: some View {
        VStack {
            ContentUnavailableView("No Favorites Saved", systemImage: "exclamationmark.magnifyingglass")
            Button {
                viewModel.showFavorites = false
            } label: {
                Text("Browse Recipes")
            }
            .buttonStyle(.bordered)
        }
    }
}
