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
        
        socket.on("drawCard") { [weak self] data, ack in
            guard
                let payload = data.first as? [String: Any],
                let cardDict = payload["card"] as? [String: Any],
                let jsonData = try? JSONSerialization.data(withJSONObject: cardDict),
                let card = try? JSONDecoder().decode(Card.self, from: jsonData)
            else {
                print("Failed to decode card from server")
                return
            }

            DispatchQueue.main.async {
                self?.handleCardDrawn(card)
            }
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("iOS Disconnected")
        }
    }
    
    func drawCard() {
        socket.emit("drawCard", ["playerID": socket.sid]) // or your player ID if stored separately
    }

    func handleCardDrawn(_ card: Card) {
        // TODO: Update GameView or shared state accordingly
    }
}
