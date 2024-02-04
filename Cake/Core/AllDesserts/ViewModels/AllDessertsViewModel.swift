//
//  AllDessertsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import Foundation
import Combine
import SwiftUI

class AllDessertsViewModel: ObservableObject {
    
    @Published var desserts: [Dessert] = []
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    @Published var imageData: [String : Data] = [:]
    @Published var filterString: String = ""
    
    init(dataService: DessertsDataServiceProrocol, cacheService: CacheServiceProtocol) {
        self.dataService = dataService
        self.cacheService = cacheService
    }
    
    let dataService: DessertsDataServiceProrocol
    let cacheService: CacheServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    var filteredDesserts: [Dessert] {
        if filterString == "" {
           let sortedDesserts = desserts.sorted(by: {$0.meal < $1.meal})
            return sortedDesserts
        } else {
            let sortedDesserts = desserts.sorted(by: {$0.meal < $1.meal})
            return sortedDesserts.filter({$0.meal.contains(filterString)})
        }
    }
    
    func fetchDesserts() async {
        do {
            let newDesserts = try await dataService.fetchAllDesserts()
            await MainActor.run {
                self.desserts = newDesserts
            }
        } catch {
            await MainActor.run {
                self.showAlert = true
                self.errorMessage = "There was an error \(error.localizedDescription)"
            }
        }
    }
    
    func getImageData(thumbURL: String) async {
        do {
            let returnedData = try await dataService.getImageData(thumbnailURL: thumbURL)
            await MainActor.run {
                cacheService.addImage(imageData: returnedData as NSData, thumbURL: thumbURL)
                imageData.updateValue(returnedData, forKey: thumbURL)
            }
        } catch {
            await MainActor.run {
                if error.localizedDescription == "cancelled" {
                    return
                } else {
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
