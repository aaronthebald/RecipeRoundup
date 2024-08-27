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
                categoryScrollView
                if viewModel.filteredItems.isEmpty && viewModel.viewIsLoading == false {
                    ContentUnavailableView(
                        "No Results in \(viewModel.selectedCategory) Found",
                        systemImage: "exclamationmark.magnifyingglass",
                        description: Text("Try Another Category!")
                    )
                    
                } else if viewModel.showFavorites && viewModel.favoriteItems.isEmpty && viewModel.viewIsLoading == false {
                    emptyFavoritesView
                }
                lazyListOfItems
                    .overlay(content: {
                        if viewModel.viewIsLoading {
                            loadingIndicator
                        }
                    })
            }
            
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
        .searchable(text: $viewModel.filterString, prompt: viewModel.isCocktail ? "Search within Cocktails" : "Search within \(viewModel.selectedCategory)")
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
    
    private var categoryScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button {
                  Task {
                   await viewModel.showFavoritesList()
                  }
                } label: {
                    CategoryIcon(image: viewModel.getCategoryIcon(categoryString: "favorite"), category: "Favorites", isSelectedTab: viewModel.showFavorites)
                }
                Button {
                    Task {
                        await viewModel.showCocktailList()
                    }
                } label: {
                    CategoryIcon(image: viewModel.getCategoryIcon(categoryString: "cocktails"), category: "Cocktails", isSelectedTab: viewModel.shouldCocktailsBeUnderlined())
                }
                ForEach(viewModel.categories, id: \.idCategory) { category in
                    Button {
                      Task {
                        await viewModel.showSelectedCategory(category: category.category)
                      }
                    } label: {
                        CategoryIcon(image: viewModel.getCategoryIcon(categoryString: category.category), category: category.category, isSelectedTab: viewModel.shouldFoodCategoryBeUnderlined(category: category.category))
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 3)
            .tint(.black)
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
            .background(.ultraThinMaterial.opacity(0.33))
    }
    
   
}
