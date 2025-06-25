#ifndef CARD_H
#define CARD_H
#include "../nlohmann/json.hpp"

#include <string>

enum CardLocation {
    hand, table, pocket
};

enum CardFaceDirection {
    up, down
};

struct Card {
    int id;
    std::string value;
    CardLocation location;
    CardFaceDirection face;
    std::string playerID;
};

using json = nlohmann::json;

void to_json(json& j, const Card& card) {
    j = json{
        {"value", card.value}
    };
}

#endif
