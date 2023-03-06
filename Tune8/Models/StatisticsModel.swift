//
//  StatisticsModel.swift
//  Tune8
//
//  Created by Administrator on 3/5/23.
//

import Foundation

struct StatisticsModel {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?

    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
