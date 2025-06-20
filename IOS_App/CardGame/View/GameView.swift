//
//  GameView.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation
import SwiftUI


struct GameView: View {
    @State var drawPile: [Card]
    @State var hand: [Card]
    
    var body: some View {
        VStack {
            Spacer()

            CardStackView(cards: drawPile)
                .frame(maxHeight: .infinity)

            Spacer()

            CardHandView(cards: hand)
                .padding(.bottom)
        }
        .padding()
        .background(Color.green.opacity(0.2))
    }
}
