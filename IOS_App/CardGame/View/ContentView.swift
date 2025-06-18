//
//  ContentView.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var socket = SocketService.shared

    var body: some View {
        VStack {
            Button("Play Card") {
                socket.playCard(card: "Ace of Spades")
            }
        }
        .onAppear {
            print("View appeared, socket is already connecting")
        }
    }
}

