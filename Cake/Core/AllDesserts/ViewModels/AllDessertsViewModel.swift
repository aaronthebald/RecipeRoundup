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
    
    init(dataService: DessertsDataServiceProrocol, cacheService: CacheServiceProtocol) {
        self.dataService = dataService
        self.cacheService = cacheService
    }
    
    let dataService: DessertsDataServiceProrocol
    let cacheService: CacheServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
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
    
    /// This function sorts the array in alphabetical order. The API Currently delivers the array in alphabetical order but if that should change the UX is preserved via this function.
    func sortDesserts() {
        let sortedDesserts = desserts.sorted(by: {$0.meal < $1.meal })
        desserts = sortedDesserts
    }
    
    func getImageData(thumbURL: String) async {
        do {
            let returnedData = try await dataService.getImageData(thumbnailURL: thumbURL)
            cacheService.addImage(imageData: returnedData as NSData, thumbURL: thumbURL)
            await MainActor.run {
                imageData.updateValue(returnedData, forKey: thumbURL)
            }
        } catch {
            await MainActor.run {
                self.showAlert = true
                self.errorMessage = error.localizedDescription
            }
        }
        
    }
}
