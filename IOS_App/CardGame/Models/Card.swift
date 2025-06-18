//
//  Card.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation

struct Card: Codable, Identifiable {
    let id: UUID
    let value: String
    var location: CardLocation
    var face: CardFaceDirection
    let imageFile: String
}

enum CardLocation: String, Codable {
    case hand
    case otherHand
    case table
    case pocket
}

enum CardFaceDirection: String, Codable {
    case up
    case down
}

