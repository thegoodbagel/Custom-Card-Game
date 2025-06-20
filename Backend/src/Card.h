#ifndef CARD_H
#define CARD_H

#include <string>

struct Card {
    int id;
    std::string value;
    CardLocation location;
    CardFaceDirection face;
    std::string playerID;
};

enum CardLocation {
    hand, table, pocket
};

enum CardFaceDirection {
    up, down
};

#endif
