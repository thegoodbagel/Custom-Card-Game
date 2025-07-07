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

inline std::vector<Card> Standard52Deck::getFullDeck() {
    std::vector<Card> fullDeck;
    const std::string ranks[] = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"};
    const std::string suits[] = {"♠️", "♥️", "♦️", "♣️"};

    for (int i = 0; i < 52; ++i) {
        Card card;
        card.id = i;

        int rankIndex = i % 13;
        int suitIndex = i / 13;

        card.value = ranks[rankIndex] + suits[suitIndex];
        card.location = CardLocation::table;
        card.face = CardFaceDirection::up;

        fullDeck.push_back(card);
    }

    return fullDeck;
}


#endif
