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
    
    @Published var state: GameState? = nil
    
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
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("iOS Connected to socket server")
            print("Socket ID:", self?.socket.sid ?? "unknown")
        }
        
        socket.on("getState") { [weak self] data, ack in
            guard
                let payload = data.first as? [String: Any],
                let jsonData = try? JSONSerialization.data(withJSONObject: payload),
                let gameState = try? JSONDecoder().decode(GameState.self, from: jsonData)
            else {
                print("Failed to decode game state from server")
                return
            }

            DispatchQueue.main.async {
                self?.handleGameState(gameState)
            }
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
    
    func getState() {
        socket.emit("getState", [:]) // or playerID if needed
    }
    
    func drawCard() {
        socket.emit("drawCard", [:])
    }
    
    func handleCardDrawn(_ card: Card) {
         getState() // pull latest state instead of modifying hand manually
    }

    func handleGameState(_ state: GameState) {
        self.state = state
    }
}
