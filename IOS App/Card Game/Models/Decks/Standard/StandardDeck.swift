//
//  StandardDeck.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation

struct StandardDeck: Deck {
    var cards: [StandardCard] = []
    var size: Int {
        cards.count
    }

    init(includeJokers: Bool = false) {
        for suit in StandardCard.Suit.allCases {
            for rank in StandardCard.Rank.allCases {
                cards.append(StandardCard(suit: suit, rank: rank))
            }
        }
        if includeJokers {
            for joker in StandardCard.Jokers.allCases {
                cards.append(StandardCard(joker: joker))
            }
        }
    }
}
