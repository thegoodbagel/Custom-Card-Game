#include "SimpleGame.h"

SimpleGame::SimpleGame() {}

std::string SimpleGame::getState() {
    // TODO
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
