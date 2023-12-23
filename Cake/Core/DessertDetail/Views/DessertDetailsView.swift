//
//  DessertDetailsView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import SwiftUI

struct DessertDetailsView: View {
    
    @StateObject var vm: DessertDetailsViewModel
    
    let dataService: DessertsDataServiceProrocol
    let mealId: String
    let imageData: Data?
    
    init(dataService: DessertsDataServiceProrocol, mealId: String, imageData: Data?) {
        _vm = StateObject(wrappedValue: DessertDetailsViewModel(dataService: dataService))
        self.dataService = dataService
        self.mealId = mealId
        self.imageData = imageData
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
                    Text("Region:")
                    Text(vm.dessertDetails.area ?? "")
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
            await vm.fetchDetails(id: mealId)
        }
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
