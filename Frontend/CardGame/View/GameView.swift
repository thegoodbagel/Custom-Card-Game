//
//  GameView.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import SwiftUI

struct GameView: View {
    @StateObject var model = GameViewModel()

    var body: some View {
        VStack {
            Spacer()

            // Draw pile (face-down cards)
            CardStackView(cards: model.drawPile)
                .frame(maxHeight: .infinity)

            Spacer()

            Button(action: {
                model.drawCard()
            }) {
                Text("Draw Card")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()

            CardHandView(cards: model.hand)
                .padding(.bottom)
        }
        .padding()
        .background(Color.green.opacity(0.2))
        .onAppear {
            model.refresh()
        }
    }
}
