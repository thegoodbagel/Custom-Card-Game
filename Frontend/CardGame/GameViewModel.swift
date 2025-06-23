//
//  GameViewModel.swift
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var drawPile: [Card] = []
    @Published var hand: [Card] = []
    @Published var otherPlayers: [String: OtherPlayerState] = [:]

    private var socket = SocketService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        socket.$state
            .compactMap { $0 }
            .sink { [weak self] state in
                self?.hand = state.hand
                self?.drawPile = Array(repeating: Card(id: "🂠", value: "🂠", face: "down"), count: state.drawPileSize)
                self?.otherPlayers = state.otherPlayers
            }
            .store(in: &cancellables)
    }

    func drawCard() {
        socket.drawCard()
    }

    func refresh() {
        socket.getState()
    }
}
