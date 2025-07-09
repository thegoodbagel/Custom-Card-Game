#include "SimpleGame.h"
#include "../nlohmann/json.hpp"
#include "Standard52Deck.h"
#include <iostream> // For debugging

SimpleGame::SimpleGame() {
    this->drawPile = Standard52Deck::getFullDeck();
    this-> players = std::unordered_map<std::string, std::unique_ptr<Player>>();
}


// One argument: string of player ID (socket ID)
// Returns the game state JSON string from the perspective of the player

std::string SimpleGame::getState(std::string playerID) {
    nlohmann::json state;

    state["drawPileSize"] = drawPile.size();

    // Add own hand
    state["hand"] = players[playerID]->getHand();

    state["playPile"] = playPile;

    // Other players: only hand sizes
    nlohmann::json others;
    for (const auto& [id, player] : players) {
        if (id != playerID) {
            others[id] = {
                {"handSize", player->getHandSize()}
                // Optionally include nickname, status, etc.
            };
        }
    }
    state["otherPlayers"] = others;

    return state.dump();  // JSON as string
}

std::optional<Card> SimpleGame::drawCard(std::string playerID) {
    if (drawPile.empty()) return std::nullopt;

    Player& player = *players[playerID];
    Card card = drawPile.back();
    drawPile.pop_back();
    player.addCardToHand(card);
    return card;
}

void SimpleGame::playCard(std::string playerID, std::string cardID) {
    Player& player = *players[playerID];
    auto& hand = player.getHand();
    auto it = std::find_if(hand.begin(), hand.end(), [&](const Card& card) {
        return card.id == cardID;
    });
    if (it != hand.end()) {
        Card card = *it;
        player.removeCardFromHand(card);
        card.location = CardLocation::table;
        card.face = CardFaceDirection::up;
        playPile.push_back(card);
        std::cout << "Player " << playerID << " played card " << cardID << std::endl;
    } else {
        std::cerr << "Card " << cardID << " not found in player " << playerID << "'s hand." << std::endl;
    }
}

void SimpleGame::addPlayer(std::string playerID) {
    players[playerID] = std::make_unique<Player>(playerID);
}

void SimpleGame::removePlayer(std::string playerID) {
    players.erase(playerID);
}
