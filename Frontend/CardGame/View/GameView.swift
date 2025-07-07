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
        VStack {
            Spacer()
            
            HStack{
                Spacer()
                
                VStack{
                                        
                    // Draw pile (face-down cards)
                    CardStackView(count: model.state?.drawPileSize ?? 0)
                    
                    Spacer()
                    
                    Button(action: {
                        model.drawCard()
                        print("Draw Card Button pressed")
                    }) {
                        Text("Draw Card")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                
                Spacer()
                
                // Play pile (face-up cards)
                CardPileView(cards: model.state?.playPile ?? [])
                
                Spacer()
            }
            
            Spacer()
            
            CardHandView(cards: model.state?.hand ?? []) { card in
                withAnimation(.easeInOut(duration: 0.4)) {
                    model.playCard(card)
                }
            }
        }
        .padding()
        .background(Color.green.opacity(0.2))
        .onAppear {
            model.refresh()
        }
    }
}
