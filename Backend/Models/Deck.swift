//
//  Deck.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation

protocol Deck {
    associatedtype CardType: Card

    var cards: [CardType] { get set }
    var size: Int { get }

    mutating func shuffle()
    mutating func deal() -> CardType?
}

extension Deck {
    mutating func shuffle() {
        cards.shuffle()
    }

    mutating func deal() -> CardType? {
        return cards.popLast()
    }
}
