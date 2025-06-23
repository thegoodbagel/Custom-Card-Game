//
//  CardView.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation
import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        Group {
            imageForCard(card)
                .resizable()
                .scaledToFit()
                .cornerRadius(8)
                .shadow(radius: 3)
        }
        .frame(width: 60, height: 90) // You can override this in the parent view if you want
        .accessibilityLabel(Text(card.value))
    }
}

func imageForCard(_ card: Card) -> Image {
    return Image(card.value)
}
