//
//  DessertDetailsView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import SwiftUI

struct ItemDetailsView: View {
    
    @StateObject private var vm: ItemDetailsViewModel
    
    let dataService: DataServiceProtocol
    let mealId: String
    let imageData: Data?
    let isCocktail: Bool
    let proAccessManager: ProAccessManager
    
    init(dataService: DataServiceProtocol, mealId: String, imageData: Data?, isCocktail: Bool, favoriteService: FavoriteService, proAccessManager: ProAccessManager) {
        _vm = StateObject(wrappedValue: ItemDetailsViewModel(dataService: dataService, favoriteService: favoriteService, proAccessManager: proAccessManager))
        self.dataService = dataService
        self.mealId = mealId
        self.imageData = imageData
        self.isCocktail = isCocktail
        self.proAccessManager = proAccessManager
    }
    
    var body: some View {
        ScrollView {
            if let imageData {
                if let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding()
                }
            }
             else {
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFit()
            }
            
            VStack(alignment: .leading) {
                HStack {
                    if let area = vm.itemDetails.area, !area.isEmpty {
                        Text("Region:")
                        Text(area)
                    }
                }
                .font(.title3)
                
                Divider()
                
                Text("Ingredients")
                    .font(.headline)
                
                IngredientListView(dessert: vm.itemDetails)
                
                Divider()
                
                Text("Instructions")
                    .font(.headline)
                
                Text(vm.itemDetails.instructions ?? "")
                
                Spacer()
                
                links
            }
            .padding(.horizontal)
            Spacer()
            
        }
        .navigationTitle(Text(vm.itemDetails.meal))
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.fetchDetails(id: mealId, isCocktail: isCocktail)
        }
        .alert("", isPresented: $vm.showAlert, actions: {
            Button {
                vm.showAlert = false
            } label: {
                Text("Dismiss")
            }
            if vm.errorMessage == vm.needToUpgradeErrorMessage {
                Button {
                    vm.makeSubscriptionPurchase()
                } label: {
                    Text("Upgrade")
                }
            }

        }, message: {
            Text(vm.errorMessage ?? "")
        })
        .toolbar {
            ToolbarItem {
                Button {
                    vm.addToFavorites(isCocktail: isCocktail, deleteItem: vm.itemIsInFavorites(isCocktail: isCocktail))
                } label: {
                    if vm.itemIsInFavorites(isCocktail: isCocktail) {
                        Label("Remove from Favorites", systemImage: "star.fill")
                    } else {
                        Label("Add to Favorites", systemImage: "star")
                    }
                }
                .tint(Color("CustomOrange", bundle: .none))
            }
        }
    }
}

extension ItemDetailsView {
    private var links: some View {
        VStack(alignment: .leading) {
            
            if let sourceString = vm.itemDetails.source, !sourceString.isEmpty, let url = URL(string: sourceString) {
                Link(destination: url, label: {
                    Text("Recipe Link")
                })
            }
            
            if let youTubeString = vm.itemDetails.youtube, !youTubeString.isEmpty, let url = URL(string: youTubeString) {
                Link(destination: url, label: {
                    Text("YouTube")
                })
            }
        }
    }
}
