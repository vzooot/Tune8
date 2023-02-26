//
//  CoinImageDataService.swift
//  Tune8
//
//  Created by Administrator on 2/26/23.
//

import Combine
import Foundation
import SwiftUI

class CoinImageDataService {
    func downloadCoinImage(imageUrl: String) -> AnyPublisher<UIImage, Error> {
        let urlString = imageUrl

        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) in
                guard let response = response as? HTTPURLResponse, (200 ... 300).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                guard let image = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                return image
            }
            .map { receivedCoinImage in
                receivedCoinImage
            }
            .eraseToAnyPublisher()
    }
}
