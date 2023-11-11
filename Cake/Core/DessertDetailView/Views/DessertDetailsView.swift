//
//  DessertDetailsView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import SwiftUI

struct DessertDetailsView: View {
    
    @StateObject var vm: DessertDetailsViewModel
    
    let dataService: DessertsDataService
    let mealId: String
    let image: QuickImage
    
    init(dataService: DessertsDataService, mealId: String, image: QuickImage) {
        _vm = StateObject(wrappedValue: DessertDetailsViewModel(dataService: dataService))
        self.dataService = dataService
        self.mealId = mealId
        self.image = image
    }
    
    var body: some View {
        ScrollView {
                image
            
                VStack(alignment: .leading) {
                    HStack {
                        Text("Region:")
                        Text(vm.dessertDetails.strArea ?? "")
                    }
                    .font(.title3)
                    
                    Divider()
                    
                    Text("Ingredients")
                        .font(.headline)
                    
                    IngredientListView(dessert: vm.dessertDetails)
                    
                    Divider()
                    
                    Text("Instructions")
                        .font(.headline)
                    
                    Text(vm.dessertDetails.strInstructions ?? "")
                    
                    Spacer()
                    
                    links
                }
                .padding(.horizontal)
                Spacer()
            
        }
        .navigationTitle(Text(vm.dessertDetails.strMeal))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            vm.fetchDetails(id: mealId)
        })
        .alert("Error", isPresented: $vm.showAlert, actions: {
            Button {
                vm.showAlert = false
            } label: {
                Text("Dismiss")
            }

        }, message: {
            Text(vm.errorMessage ?? "")
        })
    }
}

extension DessertDetailsView {
    private var links: some View {
        VStack(alignment: .leading) {
            
            // here's a better way to write this, because you always check that it's not nil and that it's not an empty string, and then to avoid force unwrapping of the URL
            if let strSource = vm.dessertDetails.strSource, !strSource.isEmpty, let url = URL(string: strSource) {
                Link(destination: url, label: {
                    Text("Recipe Link")
                })
            }
            
//            if vm.dessertDetails.strSource != "" && vm.dessertDetails.strSource != nil {
//                    let url = URL(string: vm.dessertDetails.strSource!)
//                    Link(destination: url!, label: {
//                        Text("Recipe Link")
//                    })
//            }
            
            if vm.dessertDetails.strYoutube != "" && vm.dessertDetails.strYoutube != nil {
                    let url = URL(string: vm.dessertDetails.strYoutube!)
                    Link(destination: url!, label: {
                        Text("YouTube Link")
                    })
            }
        }
    }
}
