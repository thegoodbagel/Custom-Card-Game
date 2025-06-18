//
//  Card.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation

protocol Card {
    // Must correspond to image name
    // Does not need to be unique among cards
    var id: UUID { get }
    var value: String { get }
    var location: CardLocation { get set }
    var face: CardFaceDirection { get set }
}

enum CardLocation {
    case hand
    case otherHand
    case table
    case pocket
}

enum CardFaceDirection{
    case up
    case down
}
