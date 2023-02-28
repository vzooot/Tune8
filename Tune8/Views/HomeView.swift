//
//  HomeView.swift
//  Tune8
//
//  Created by Administrator on 2/25/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var animate: Bool = true

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            VStack {
                homeHeader

                SearchBarView(searchText: $vm.searchText)
                
                columnTitles

                if showPortfolio {
                    portfolioList
                        .transition(.move(edge: .leading))
                } else {
                    allCoinsList
                        .transition(.move(edge: .trailing))
                }

                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.mockHomeVM)
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(image: showPortfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: $animate)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
            Spacer()
            CircleButtonView(image: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    if animate == true {
                        withAnimation(.spring()) {
                            showPortfolio.toggle()
                        }
                        animate = false
                    } else {
                        withAnimation(.spring()) {
                            showPortfolio.toggle()
                            animate = true
                        }
                    }
                }
        }
    }

    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            Text(showPortfolio ? "Holdings" : "")
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
    }

    private var portfolioList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in

                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowBackground(Color.theme.background)
            }

            .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .listStyle(.plain)
    }

    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in

                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowBackground(Color.theme.background)
            }
            .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .listStyle(.plain)
    }
}
