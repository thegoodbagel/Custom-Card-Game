//
//  CardView.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation
import SwiftUI

struct CardView<CardType: Card>: View {
    let card: CardType
    let onSwipeUp: () -> Void
    let onSwipeDown: () -> Void

    var body: some View {
        Group {
            if card.face == .up {
                Image(card.value)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .shadow(radius: 3)
            } else {
                Image("card_back") // Make sure you have a card_back asset in your project
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .shadow(radius: 3)
            }
        }
        .frame(width: 60, height: 90) // You can override this in the parent view if you want
        .gesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    if value.translation.height < -20 {
                        onSwipeUp()
                    } else if value.translation.height > 20 {
                        onSwipeDown()
                    }
                }
        )
        .accessibilityLabel(Text(card.value))
    }
}
