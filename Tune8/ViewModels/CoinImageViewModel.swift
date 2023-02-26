//
//  CoinImageViewModel.swift
//  Tune8
//
//  Created by Administrator on 2/26/23.
//

import Combine
import Foundation
import SwiftUI

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    let coin: CoinModel

    private let dataService = CoinImageDataService()
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coin = coin
        getImage()
    }

    func getImage() {
        dataService.getCoinImage(imageUrl: coin.image)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] receivedImage in
                self?.image = receivedImage
            }
            .store(in: &cancellables)
    }
}
