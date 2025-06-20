#include "Player.h"

Player::Player(std::string playerID) {
    id = playerID;
    name = "Player_" + playerID; // Default name based on ID
    hand = std::vector<Card>();
}

std::string Player::getID() {
    return id;
}

std::string Player::getName() {
    return name;
}

void Player::addCardToHand(Card card) {
    hand.push_back(card);
}

void Player::removeCardFromHand(Card card) {
    hand.erase(std::remove(hand.begin(), hand.end(), card), hand.end());
}



