//
//  CardPileView.swift
//  CardGame
//
//  Created by Abrianna Zhang on 7/7/25.
//

import Foundation
import SwiftUI

struct CardPileView: View {
    let cards: [Card]

    var body: some View {
        ZStack {
            ForEach(cards.indices, id: \.self) { index in
                CardView(card: cards[index])
                    .offset(x: CGFloat(index) * 0.5, y: CGFloat(index) * 0.5)
                    .zIndex(Double(index)) // optional, to control stacking order
            }
        }
        .frame(width: 60 + CGFloat(cards.count) * 0.5,
               height: 90 + CGFloat(cards.count) * 0.5)
    }
}
