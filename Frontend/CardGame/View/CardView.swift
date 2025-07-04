//
//  CardView.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation
import SwiftUI
import UIKit

struct CardView: View {
    let card: Card

    var body: some View {
        Group {
            if card.face == "up", let uiImage = UIImage(named: card.value) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else if card.face == "down" {
                Image("card_back")
                    .resizable()
                    .scaledToFit()
            } else {
                // Fallback rectangle if image doesn't exist
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray)
                    Text(card.value)
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
        .frame(width: 60, height: 90)
        .cornerRadius(8)
        .shadow(radius: 3)
        .accessibilityLabel(Text(card.value))
    }
}

struct CardBackView: View {
    var body: some View {
        Image("card_back")
            .resizable()
            .scaledToFit()
            .cornerRadius(8)
            .shadow(radius: 3)
            .frame(width: 60, height: 90)
    }
}
