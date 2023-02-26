//
//  CircleButtonView.swift
//  Tune8
//
//  Created by Administrator on 2/25/23.
//

import SwiftUI

struct CircleButtonView: View {
    let image: String
    var body: some View {
        Image(systemName: image)
            .font(Font.system(size: 18))
            .foregroundColor(.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(.theme.background)
            )
            .shadow(color: .theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(image: "heart.fill")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
