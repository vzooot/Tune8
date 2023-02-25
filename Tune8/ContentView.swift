//
//  ContentView.swift
//  Tune8
//
//  Created by Administrator on 2/25/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = HomeViewModel()

    var body: some View {
        NavigationStack {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
