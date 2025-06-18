//
//  GameView.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation

// Filter game state to information relative to display
class GameView<DeckType: Deck>: ObservableObject {
    @Published var deck: DeckType
    @Published var cards: [DeckType.CardType]

    init(deck: DeckType) {
        self.deck = deck
        self.cards = deck.cards
    }

    func move(card: DeckType.CardType, to location: CardLocation) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].location = location
        }
    }

    var myHand: [DeckType.CardType] {
        cards.filter { $0.location == .hand }
    }

    var table: [DeckType.CardType] {
        cards.filter { $0.location == .table }
    }

    var pocket: [DeckType.CardType] {
        cards.filter { $0.location == .pocket }
    }
}
