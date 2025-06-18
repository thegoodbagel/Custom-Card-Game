//
//  StandardCard.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation

struct StandardCard: Card, Identifiable {
    // Nested enums
    enum Suit: String, CaseIterable {
        case spades = "♠️", hearts = "♥️", clubs = "♣️", diamonds = "♦️"
    }

    enum Rank: String, CaseIterable {
        case two = "2", three = "3", four = "4", five = "5", six = "6",
             seven = "7", eight = "8", nine = "9", ten = "10",
             jack = "J", queen = "Q", king = "K", ace = "A"
    }

    enum Jokers: String, CaseIterable {
        case redJoker = "red joker", blackJoker = "black Joker"
    }

    let id = UUID()
    var kind: CardKind
    var location: CardLocation = .table
    var face: CardFaceDirection = .down

    enum CardKind {
        case standard(suit: Suit, rank: Rank)
        case joker(Jokers)
    }

    var value: String {
        switch kind {
        case .standard(let suit, let rank):
            return "\(rank.rawValue) of \(suit.rawValue)"
        case .joker(let jokerType):
            return jokerType.rawValue.capitalized
        }
    }

    init(suit: Suit, rank: Rank) {
        self.kind = .standard(suit: suit, rank: rank)
    }

    init(joker: Jokers) {
        self.kind = .joker(joker)
    }
}
