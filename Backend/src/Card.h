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
    std::string id;
    std::string value;
    CardLocation location;
    CardFaceDirection face;
    std::string playerID;
    bool operator==(const Card& other) const {
        return id == other.id;
    }
};

using json = nlohmann::json;

inline void to_json(json& j, const Card& card) {
    j = json{
        {"value", card.value}
    };
}

#endif
