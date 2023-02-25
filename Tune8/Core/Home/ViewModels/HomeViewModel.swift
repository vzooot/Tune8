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

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperPreview.instance.mockCoin)
            self.portfolioCoins.append(DeveloperPreview.instance.mockCoin)
        }
    }
}
