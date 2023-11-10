//
//  DessertDetailsView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import SwiftUI

struct DessertDetailsView: View {
    
    @StateObject var vm: DessertDetailsViewModel = DessertDetailsViewModel()
    
    let mealId: String
    
    var body: some View {
        ScrollView {
                QuickImage(url: URL(string: vm.dessertDetails.strMealThumb))
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
        .navigationTitle(vm.dessertDetails.strMeal)
        .onAppear(perform: {
            vm.fetchDetails(id: mealId)
        })
    }
}

#Preview {
    DessertDetailsView(mealId: "52893")
}

extension DessertDetailsView {
    private var links: some View {
        VStack(alignment: .leading) {
            if vm.dessertDetails.strSource != "" && vm.dessertDetails.strSource != nil {
                    let url = URL(string: vm.dessertDetails.strSource!)
                    Link(destination: url!, label: {
                        Text("Recipe Link")
                    })
            }
            
            if vm.dessertDetails.strYoutube != "" && vm.dessertDetails.strYoutube != nil {
                    let url = URL(string: vm.dessertDetails.strYoutube!)
                    Link(destination: url!, label: {
                        Text("YouTube Link")
                    })
            }
        }
    }
}
