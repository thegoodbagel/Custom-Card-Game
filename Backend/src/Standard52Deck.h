#ifndef STANDARD52DECK_H
#define STANDARD52DECK_H

#include "Card.h"
#include <string>

struct Standard52Deck {
    int id = 0;
    std::string name = "Standard 52 Card Deck";
    int size = 52;
    static std::vector<Card> getFullDeck();
};

std::vector<Card> Standard52Deck::getFullDeck() {
    std::vector<Card> fullDeck;
    for (int i = 0; i < 52; ++i) {
        Card card;
        card.id = i;
        card.value = std::to_string(i % 13 + 1);
        card.location = CardLocation::table;
        card.face = CardFaceDirection::up;
        fullDeck.push_back(card);
    }
    return fullDeck;
}

#endif
