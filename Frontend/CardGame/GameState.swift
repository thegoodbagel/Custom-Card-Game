//
//  GameState.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation

struct GameState: Codable {
    let drawPileSize: Int
    let hand: [Card]
    let otherPlayers: [String: OtherPlayerState]?
    let playPile: [Card]
}

struct Card: Codable, Identifiable {
    var id: String 
    let value: String
    let location: String
    let face: String
}

struct OtherPlayerState: Codable {
    let handSize: Int
}

