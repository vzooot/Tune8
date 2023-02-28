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
    @Published var searchText: String = ""

    var cancellables = Set<AnyCancellable>()

    private let dataService = CoinDataService()

    init() {
        addSubscribers()
    }

    func addSubscribers() {
        $searchText
            .setFailureType(to: Error.self)
            .combineLatest(dataService.getCoins().eraseToAnyPublisher())
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text, startingCoins -> [CoinModel] in
                guard !text.isEmpty else {
                    return startingCoins
                }

                let lowercasedText = text.lowercased()

                let filteredCoins = startingCoins.filter { coin -> Bool in
                    coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText)
                }

                return filteredCoins
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    self.handleCompletion(completion: completion)
                },
                receiveValue: { returnedCoin in
                    self.allCoins = returnedCoin
                }
            )
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
