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
            VStack(alignment: .leading) {
                QuickImage(url: getImageURL())
                VStack(alignment: .leading) {
                    Text(vm.dessertDetails.strMeal)
                        .font(.title2)
                    HStack {
                        Text("Region:")
                        Text(vm.dessertDetails.strArea)
                    }
                    .font(.title3)
                    Text("Ingredients")
                        .font(.headline)
                    IngredientListView(dessert: vm.dessertDetails)
                    
                    Text("Instructions")
                        .font(.headline)
                    Divider()
                    Text(vm.dessertDetails.strInstructions)
                }
                .padding(.horizontal, 5)
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: {
            vm.fetchDetails(id: mealId)
        })
    }
}

#Preview {
    DessertDetailsView(mealId: "52893")
}

extension DessertDetailsView {
    
    private func getImageURL() -> URL {
        guard let url = URL(string: vm.dessertDetails.strMealThumb) else { return URL(string: "www.google.com")!}
        return url
    }
}
