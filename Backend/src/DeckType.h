#ifndef DECK_H
#define DECK_H

#include <Card.h>

// I guess for display? idk
struct DeckType {
    int id;
    std::string name;
    std::vector<Card> fullDeck; 
    int size;
};
#endif
