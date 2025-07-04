//
//  CardStackView.swift
//  CardGame
//
//  Created by Abrianna Zhang on 6/20/25.
//

import Foundation
import SwiftUI

struct CardStackView: View {
    let count: Int

    var body: some View {
        ZStack {
            ForEach(0..<count, id: \.self) { index in
                CardBackView()
                    .offset(x: CGFloat(index) * 0.5, y: CGFloat(index) * 0.5)
                    .zIndex(Double(index)) // optional, to control stacking order
            }
        }
        .frame(width: 60 + CGFloat(count) * 0.5, height: 90 + CGFloat(count) * 0.5)
    }
}
