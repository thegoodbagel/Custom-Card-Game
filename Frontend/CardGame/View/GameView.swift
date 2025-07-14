//
//  GameView.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import SwiftUI

struct GameView: View {
    @StateObject var model = Game()

    var body: some View {
        VStack(spacing: 16) {
            // Title
            Text("Card Game")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)

            Spacer(minLength: 10)

            // Center area: Draw pile and Play pile
            HStack(alignment: .top, spacing: 40) {
                // Draw pile and draw button
                VStack(spacing: 16) {
                    CardStackView(count: model.state?.drawPileSize ?? 0)

                    Button(action: {
                        model.drawCard()
                        print("Draw Card Button pressed")
                    }) {
                        Text("Draw Card")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                }

                // Play pile (face-up cards)
                CardPileView(cards: model.state?.playPile ?? [])
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)

            Spacer()

            // Player's hand
            VStack(alignment: .leading, spacing: 8) {
                Text("Your Hand")
                    .font(.headline)
                    .padding(.leading)

                CardHandView(cards: model.state?.hand ?? []) { card in
                    withAnimation(.easeInOut(duration: 0.4)) {
                        model.playCard(card)
                    }
                }
            }
            .padding(.bottom)

        }
        .padding()
        .background(Color.green.opacity(0.15).ignoresSafeArea())
        .onAppear {
            model.refresh()
        }
    }
}
