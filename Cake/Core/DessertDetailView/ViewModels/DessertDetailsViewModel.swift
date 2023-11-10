//
//  DessertDetailsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/7/23.
//

import Foundation
import Combine

class DessertDetailsViewModel: ObservableObject {
    @Published var dessertDetails: DessertDetailsModel = .placeholderDetails
    init(dataService: DessertsDataService) {
        self.dataService = dataService
        subscribeToDessertDetails()
    }
    
    let dataService: DessertsDataService
    var cancellables = Set<AnyCancellable>()
    func subscribeToDessertDetails() {
        dataService.$dessertDetails
            .sink { [weak self] dessertDetails in
                guard let dessertsDetails = dessertDetails else { return }
                self?.dessertDetails = dessertsDetails
            }
            .store(in: &cancellables)
    }
    func fetchDetails(id: String) {
        dataService.fetchDessertDetails(mealID: id)
    }
}
