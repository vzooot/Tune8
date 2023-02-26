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
    let fileManager = LocalFileManager.instance
    let folderName = "coin_images"
    let imageName: String
    let coin: CoinModel

    private let dataService = CoinImageDataService()
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel, imageName: String) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }

    func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedImage
            print("Retrieved")
        } else {
            downloadCoinImage()
            print("Downloaded")
        }
    }

    func downloadCoinImage() {
        dataService.downloadCoinImage(imageUrl: coin.image)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] receivedImage in
                guard let self = self else { return }
                self.image = receivedImage
                self.fileManager.saveImage(image: receivedImage, imageName: self.imageName, folderName: self.folderName)
            }
            .store(in: &cancellables)
    }
}
