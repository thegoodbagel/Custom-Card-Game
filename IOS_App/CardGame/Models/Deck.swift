//
//  Deck.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation

struct Deck: Codable {
    var cards: [Card]
    
    var size: Int {
        cards.count
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func deal() -> Card? {
        cards.popLast()
    }
    
    let cardBackImageFile: String
}
