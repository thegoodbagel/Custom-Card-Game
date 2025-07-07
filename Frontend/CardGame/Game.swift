//
//  Game.swift
//

import Foundation
import Combine

class Game: ObservableObject {
    @Published var state: GameState?
    private var socket = SocketService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        socket.$state
            .compactMap { $0 } // drop nil values
            .sink { [weak self] newState in
                self?.state = newState // update state
            }
            .store(in: &cancellables) // store subscription
    }
    
    func drawCard() {
        print("Drawing a card")
        socket.emitDrawCard()
    }
    
    func playCard(_ card: Card) {
        guard let index = state?.hand.firstIndex(where: { $0.id == card.id }) else { return }
        print("Playing a card")
        socket.emitPlayCard(card)
    }
    
    func refresh(){
        socket.getState()
    }
}
