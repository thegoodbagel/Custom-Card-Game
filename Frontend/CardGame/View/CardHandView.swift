//
//  CardHandView.swift
//  CardGame
//
//  Created by Abrianna Zhang on 6/20/25.
//

import Foundation
import SwiftUI
struct CardHandView: View {
    let cards: [Card]
//    var onCardTap: ((Card) -> Void)? = nil

    var body: some View {
        GeometryReader { geometry in
            HandLayout(cards: cards, maxWidth: geometry.size.width /*, onCardTap: onCardTap*/)
        }
        .frame(height: 200)
    }
}

struct HandLayout: View {
    let cards: [Card]
    let maxWidth: CGFloat
//    var onCardTap: ((Card) -> Void)? = nil

    var body: some View {
        let maxPerRow = max(Int(maxWidth / 50), 1)
        let splitRows = cards.chunked(into: maxPerRow)

        return VStack(spacing: -30) {
            ForEach(splitRows.indices, id: \.self) { rowIndex in
                HStack(spacing: -20) {
                    ForEach(splitRows[rowIndex]) { card in
                        CardView(card: card)
//                            .onTapGesture {
//                                onCardTap?(card)
//                            }
                    }
                }
            }
        }
        .frame(width: maxWidth)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
