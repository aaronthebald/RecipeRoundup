//
//  NetworkingManager.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import Foundation
import Combine


class AllDessertsDataService: ObservableObject {
   
    init() {
        fetchAllDesserts()
    }
    @Published var desserts: [Dessert] = []
    @Published var dessertDetails: DessertDetailsModel?
    
    var cancellables = Set<AnyCancellable>()
    func fetchAllDesserts()  {
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { print("There was an error with the allDessertsURL"); return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: AllDessertsResponse.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error downloading data\(error)")
                }
            } receiveValue: { [weak self] returnedResponse in
                self?.desserts = returnedResponse.meals
            }
            .store(in: &cancellables)
    }
    
    func fetchDessertDetails(mealID: String)  {
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else { print("There was an error with the dessertDetails URL"); return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: DessertDetailsResponseModel.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error downloading data\(error)")
                }
            } receiveValue: { [weak self] returnedResponse in
                self?.dessertDetails = returnedResponse.meals.first
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        
        guard
            let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

