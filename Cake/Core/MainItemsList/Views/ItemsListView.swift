//
//  AllDessertsView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI
import RevenueCat

struct ItemsListView: View {
    
    @StateObject private var viewModel = ItemsListViewModel(dataService: DataService(), cacheService: CacheService())
    @EnvironmentObject var proAccessManager: ProAccessManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.filteredItems.isEmpty && viewModel.viewIsLoading == false {
                    ContentUnavailableView("No Items Found", systemImage: "exclamationmark.magnifyingglass")
                } else if viewModel.showFavorites && viewModel.favoriteItems.isEmpty && viewModel.viewIsLoading == false {
                    emptyFavoritesView
                }
                lazyListOfItems
            }
            .overlay(content: {
                if viewModel.viewIsLoading {
                    loadingIndicator
                }
            })
            .onChange(of: viewModel.selectedCategory, { _, newCategory in
                Task {
                    if newCategory != "" {
                        viewModel.showFavorites = false
                        viewModel.isCocktail = false
                        await viewModel.fetchItems(category: newCategory)
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
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    categoriesMenu
                }
                ToolbarItem {
                    settingsMenuButton
                }
            }
            .sheet(isPresented: $viewModel.showSettingSheet, content: {
                SettingsView(proAccessManager: proAccessManager)
            })
        }
        .onAppear {
            Purchases.shared.getCustomerInfo { info, error in
                if info?.entitlements["proaccess"]?.isActive == true {
                    print("pro access checked")
                    self.proAccessManager.isProAccess = true
                }
            }
        }
        .searchable(text: $viewModel.filterString, prompt: "Search within category")
    }
}

#Preview {
    ItemsListView()
}

extension ItemsListView {
    
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
    
    private var lazyListOfItems: some View {
        LazyVStack(alignment: .leading) {
            ForEach(viewModel.showFavorites ? viewModel.favoriteItems : viewModel.filteredItems, id: \.id) { item in
//                    This if statement checks to see if the needed data for the image of the item is currently in the cache.
                if let cacheData = viewModel.cacheService.getImage(thumbURL: item.thumb) {
                    NavigationLink {
                        ItemDetailsView(dataService: viewModel.dataService, mealId: item.id, imageData: cacheData as Data, isCocktail: item.isCocktail, favoriteService: viewModel.favoriteService, proAccessManager: proAccessManager)
                    } label: {
                        ItemRowView(dessert: item.name, imageData: cacheData as Data)
                    }
                }
                else {
                    NavigationLink {
                        ItemDetailsView(dataService: viewModel.dataService, mealId: item.id, imageData: viewModel.imageData[item.thumb] ?? nil, isCocktail: item.isCocktail, favoriteService: viewModel.favoriteService, proAccessManager: proAccessManager)
                    } label: {
                        ItemRowView(dessert: item.name, imageData: viewModel.imageData[item.thumb] ?? nil )
                    }
                    .task {
                        await viewModel.getImageData(thumbURL: item.thumb)
                    }
                }
            }
        }
        .padding(.horizontal, 4)
    }
    
    private var categoriesMenu: some View {
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
    
    private var settingsMenuButton: some View {
        Button {
            viewModel.showSettingSheet = true
        } label: {
            Image(systemName: "gear")
        }
    }
    
    private var loadingIndicator: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(.ultraThinMaterial)
    }
}
