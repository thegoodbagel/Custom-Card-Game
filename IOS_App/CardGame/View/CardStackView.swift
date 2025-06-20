//
//  CardStackView.swift
//  CardGame
//
//  Created by Abrianna Zhang on 6/20/25.
//

import Foundation
import SwiftUI

struct CardStackView: View {
    let cards: [Card]

    var body: some View {
        ZStack {
            ForEach(cards.indices, id: \.self) { index in
                CardView(card: cards[index])
                    .offset(x: CGFloat(index) * 0.5, y: CGFloat(index) * -2) // subtle displacement
                    .zIndex(Double(index))
            }
        }
        .frame(width: 70, height: 100)
        .accessibilityLabel(Text("Draw pile with \(cards.count) cards"))
    }
}
