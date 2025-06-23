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

        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("iOS Disconnected")
        }
    }
    
    func getState() {
        socket.emit("getState", [:]) // or playerID if needed
    }

    func handleGameState(_ state: GameState) {
        // Update your app UI, ViewModel, or shared state
    }
}
