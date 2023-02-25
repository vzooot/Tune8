//
//  CoinDataService.swift
//  Tune8
//
//  Created by Administrator on 2/25/23.
//

import Combine
import Foundation

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var cancellables = Set<AnyCancellable>()

    init() {
        getCoins()
    }

    func getCoins() {
        let baseUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
        guard let url = URL(string: baseUrl) else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) in
                guard let response = response as? HTTPURLResponse, (200 ... 300).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }

                return data
            }
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Network request finished successfully.")
                case .failure(let error):
                    print("Error:", error)
                }
            }, receiveValue: { [weak self] coins in
                self?.allCoins = coins
            })
            .store(in: &cancellables)
    }
}
