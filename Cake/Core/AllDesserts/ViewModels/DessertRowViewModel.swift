//
//  DessertRowViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 12/17/23.
//

import Foundation
import SwiftUI

class DessertRowViewModel: ObservableObject {
    
    @Published var image: Image? = nil
    @Published var imageIsLoading: Bool = true
    
    let dataService: DessertsDataServiceProrocol
    let cacheService: CacheServiceProtocol
    let dessert: Dessert
    init(dataService: DessertsDataServiceProrocol, cacheService: CacheServiceProtocol, dessert: Dessert) {
        self.dataService = dataService
        self.cacheService = cacheService
        self.dessert = dessert
    }
    
    func getImage() async {
        if let data = cacheService.getImage(thumbURL: dessert.mealThumb) {
            guard let uiImage = UIImage(data: data as Data) else { return }
            self.image = Image(uiImage: uiImage)
            imageIsLoading = false
        } else {
            do {
                let data = try await dataService.getImageData(thumbnailURL: dessert.mealThumb)
                cacheService.addImage(imageData: data as NSData, thumbURL: dessert.mealThumb)
                guard let uiImage = UIImage(data: data) else { return }
                await MainActor.run {
                    self.image = Image(uiImage: uiImage)
                    imageIsLoading = false
                }
            } catch {
                print("there was an error \(error.localizedDescription)")
            }
        }
    }
}
