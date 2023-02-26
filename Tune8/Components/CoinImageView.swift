//
//  CoinImageView.swift
//  Tune8
//
//  Created by Administrator on 2/26/23.
//

import Combine
import SwiftUI

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel

    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }

    var body: some View {
        if let image = vm.image {
            Image(uiImage: image)
                .resizable()

        } else {
            Image(systemName: "heart")
                .resizable()

        }

    }
}

 struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.mockCoin)
    }
 }
