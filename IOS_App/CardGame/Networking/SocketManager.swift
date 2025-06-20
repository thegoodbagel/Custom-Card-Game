//
//  SocketManager.swift
//  Card Game
//
//  Created by Abrianna Zhang on 6/17/25.
//

import Foundation
import SocketIO

class SocketService: ObservableObject {
    static let shared = SocketService()
    
    private var manager: SocketManager
    private var socket: SocketIOClient

    private init() {
        // ⚠️ Replace with your actual IP address or hostname when testing on device
        let url = URL(string: "http://localhost:3000")!
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        socket = manager.defaultSocket

        setupHandlers()
        socket.connect()
    }

    private func setupHandlers() {
        socket.on(clientEvent: .connect) { data, ack in
            print("iOS Connected to socket server")
        }

        socket.on("drawCard") { data, ack in
            print("Received move:", data)
            // Handle incoming card event (e.g., update UI)
        }

        socket.on(clientEvent: .disconnect) { data, ack in
            print("iOS Disconnected")
        }
    }

//    // Put elsewhere
//    func playCard(card: String) {
//        socket.emit("playCard", card)
//    }
}
