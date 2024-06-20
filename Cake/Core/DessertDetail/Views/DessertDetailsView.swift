//
//  DessertDetailsView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import SwiftUI

struct DessertDetailsView: View {
    
    @StateObject private var vm: DessertDetailsViewModel
    
    let dataService: DataServiceProtocol
    let mealId: String
    let imageData: Data?
    let isCocktail: Bool
    let proAccessManager: ProAccessManager
    
    init(dataService: DataServiceProtocol, mealId: String, imageData: Data?, isCocktail: Bool, favoriteService: FavoriteService, proAccessManager: ProAccessManager) {
        _vm = StateObject(wrappedValue: DessertDetailsViewModel(dataService: dataService, favoriteService: favoriteService, proAccessManager: proAccessManager))
        self.dataService = dataService
        self.mealId = mealId
        self.imageData = imageData
        self.isCocktail = isCocktail
        self.proAccessManager = proAccessManager
    }
    
    var body: some View {
        ScrollView {
            if imageData != nil {
                if let image = UIImage(data: imageData!) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
             else {
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFit()
            }
            
            
            
            VStack(alignment: .leading) {
                HStack {
                    if vm.dessertDetails.area != nil && vm.dessertDetails.area != "" {
                        Text("Region:")
                        Text(vm.dessertDetails.area ?? "")
                    }
                }
                .font(.title3)
                
                Divider()
                
                Text("Ingredients")
                    .font(.headline)
                
                IngredientListView(dessert: vm.dessertDetails)
                
                Divider()
                
                Text("Instructions")
                    .font(.headline)
                
                Text(vm.dessertDetails.instructions ?? "")
                
                Spacer()
                
                links
            }
            .padding(.horizontal)
            Spacer()
            
        }
        .navigationTitle(Text(vm.dessertDetails.meal))
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

extension DessertDetailsView {
    private var links: some View {
        VStack(alignment: .leading) {
            
            if let strSource = vm.dessertDetails.source, !strSource.isEmpty, let url = URL(string: strSource) {
                Link(destination: url, label: {
                    Text("Recipe Link")
                })
            }
            
            if let youTubeString = vm.dessertDetails.youtube, !youTubeString.isEmpty, let url = URL(string: youTubeString) {
                Link(destination: url, label: {
                    Text("YouTube")
                })
            }
        }
    }
}
