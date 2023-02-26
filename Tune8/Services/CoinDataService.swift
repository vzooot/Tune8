//
//  CoinDataService.swift
//  Tune8
//
//  Created by Administrator on 2/25/23.
//

import Combine
import Foundation

class CoinDataService {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown

        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url):
                return "Bad response from url: \(url)"
            case .unknown:
                return "Unknown error"
            }
        }
    }

    func getCoins() -> AnyPublisher<[CoinModel], Error> {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) in
                try self.handleURLResponse(data: data, response: response, url: url)
            }
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .map { $0 }
            .eraseToAnyPublisher()
    }

    func handleURLResponse(data: Data, response: URLResponse, url: URL) throws -> Data {
        guard let response = response as? HTTPURLResponse, (200 ... 300).contains(response.statusCode) else {
            throw NetworkingError.badURLResponse(url: url)
        }

        return data
    }
}
