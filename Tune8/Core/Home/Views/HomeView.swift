//
//  HomeView.swift
//  Tune8
//
//  Created by Administrator on 2/25/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio: Bool = false
    @State private var animate: Bool = true

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            VStack {
                homeHeader
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
        .padding()
    }
}
