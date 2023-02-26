//
//  HomeViewModel.swift
//  Tune8
//
//  Created by Administrator on 2/25/23.
//

import Combine
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    private let dataService = CoinDataService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.getCoins()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.handleCompletion(completion: completion)
            }, receiveValue: { returnedCoin in
                self.allCoins = returnedCoin
            })
            .store(in: &cancellables)
    }
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case let .failure(error):
            // Handle the error
            print("Error: \(error.localizedDescription)")
        case .finished:
            break
        }
    }
}
