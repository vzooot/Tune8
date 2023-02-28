//
//  UIApplication.swift
//  Tune8
//
//  Created by Administrator on 2/26/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
