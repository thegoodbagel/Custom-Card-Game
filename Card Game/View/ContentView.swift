//
//  ContentView.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject private var game = GameView(deck: StandardDeck())

    var body: some View {
        VStack {
            Button("Draw Card") {
                if let card = game.deck.deal() {
                    game.cards.append(card)
                    game.move(card: card, to: .hand)
                }
            }

            ScrollView(.horizontal) {
                HStack {
                    ForEach(game.myHand) { card in
                        CardView(card: card, onSwipeUp: {
                            game.move(card: card, to: .table)
                        }, onSwipeDown: {
                            game.move(card: card, to: .pocket)
                        })
                        .frame(width: 80, height: 120)
                        .padding(4)
                    }
                }
            }

            Spacer()

            Text("Table Cards")
            ScrollView(.horizontal) {
                HStack {
                    ForEach(game.table) { card in
                        CardView(card: card, onSwipeUp: {}, onSwipeDown: {})
                            .frame(width: 60, height: 90)
                    }
                }
            }
        }
        .padding()
    }
}
