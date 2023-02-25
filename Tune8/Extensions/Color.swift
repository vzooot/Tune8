//
//  Color.swift
//  Tune8
//
//  Created by Administrator on 2/25/23.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let blue = Color("BlueColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
