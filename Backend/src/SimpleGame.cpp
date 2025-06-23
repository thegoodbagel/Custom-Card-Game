#include "SimpleGame.h"
#include <../nlohmann/json.hpp>
#include "Standard52Deck.h"

SimpleGame::SimpleGame() {
    this->drawPile = Standard52Deck::getFullDeck();
    this-> players = std::unordered_map<std::string, std::unique_ptr<Player>>();
}

std::string SimpleGame::getState(std::string playerID) {
    // For now, there are only three possible locations:
    // Cards on table (draw pile),
    // Cards in players' hands,
    // Cards in other player's hands (invisible for now)
    // Send over the appropriate state of the game
    nlohmann::json state;

    state["drawPileSize"] = drawPile.size();

    // Add own hand
    state["hand"] = players[playerID]->getHand();

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

Card SimpleGame::drawCard(std::string playerID) {
    Player player = *players[playerID];
    Card card = drawPile.back();
    drawPile.pop_back();
    player.addCardToHand(card);
    return card;
}

void SimpleGame::addPlayer(std::string playerID) {
    players[playerID] = std::make_unique<Player>(playerID);
}
