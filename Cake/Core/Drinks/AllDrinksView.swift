//
//  AllDrinksView.swift
//  Cake
//
//  Created by Aaron Wilson on 2/4/24.
//

import SwiftUI

struct AllDrinksView: View {
    
    @StateObject private var vm = AllDrinksViewModel(dataService: DessertsDataService(), cacheService: CacheService())
    
    var body: some View {
        ScrollView {
            ForEach(vm.AllDrinks, id: \.idDrink) { drink in
                DessertRowView(dessert: drink.drink, imageData: nil)
            }
        }
        .task {
            await vm.fetchAllCocktails()
        }
    }
}

#Preview {
    AllDrinksView()
}
