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
    @Published var isConnected: Bool = false
    
    private var manager: SocketManager
    private var socket: SocketIOClient
    
    private init() {
        
        let url = URL(string: "http://localhost:3000")!
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        setupHandlers()
        socket.connect()
    }
    
    private func setupHandlers() {
        // connect event - fires when socket connects to server
        socket.on(clientEvent: .connect) { [weak self] data, ack in // keep weak reference to socket
            print("iOS Connected to socket server")
            print("Socket ID:", self?.socket.sid ?? "unknown")
            DispatchQueue.main.async {
                self?.isConnected = true
            }
        }
        // getState event -> JSON format of game state:
        socket.on("getState") { [weak self] data, ack in
            if let payload = data.first as? [String: Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: payload)
                    let gameState = try JSONDecoder().decode(GameState.self, from: jsonData)
                    DispatchQueue.main.async {
                        self?.updateGameState(gameState)
                    }
                } catch {
                    print("Decoding failed:", error)
                }
            }
        }

        socket.on(clientEvent: .disconnect) { data, ack in
            print("iOS Disconnected")
        }
    }
    
    func getState() {
        guard isConnected else {
            print("Socket not connected — getState aborted")
            return
        }
        socket.emit("getState", socket.sid ?? "unknown") // or playerID if needed
    }
    
    func emitDrawCard() {
        guard isConnected else {
            print("Socket not connected — drawCard aborted")
            return
        }
        print("Connected, emitting drawn card")
        socket.emit("drawCard", [] as [Any])
    }
    
    func emitPlayCard(_ card: Card) {
        guard isConnected else {
            print("Socket not connected — playCard aborted")
            return
        }
        print("Connected, playing card")
        socket.emit("playCard", card.id)
    }

    func updateGameState(_ state: GameState) {
        self.state = state
    }
}
