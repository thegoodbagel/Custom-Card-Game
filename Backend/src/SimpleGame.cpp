#include "SimpleGame.h"

SimpleGame::SimpleGame() {}

std::string SimpleGame::getState() {
    // TODO
}

void SimpleGame::drawCard(std::string playerID, Card card) {
    Player player = *players[playerID];
    drawPile.pop_back();

    // Add the card to the player's hand
    player.addCardToHand(card);
}

void SimpleGame::addPlayer(std::string playerID) {
    players[playerID] = std::make_unique<Player>(playerID);
}
