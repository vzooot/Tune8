//
//  StatisticsView.swift
//  Tune8
//
//  Created by Administrator on 3/5/23.
//

import SwiftUI

struct StatisticsView: View {
    let stat: StatisticsModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? .theme.blue : .theme.red)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(stat: dev.stat1)
        StatisticsView(stat: dev.stat2)
        StatisticsView(stat: dev.stat3)
    }
}
