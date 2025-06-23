//
//  Card.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation

struct Card: Codable, Identifiable {
    var id: UUID = UUID()
    let value: String
}

struct OtherPlayerState: Codable {
    let handSize: Int
}

struct GameState: Codable {
    let drawPileSize: Int
    let hand: [Card]
    let otherPlayers: [String: OtherPlayerState]
}

