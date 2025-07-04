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
    // Helper lambdas to convert enum values to strings
    auto locationToString = [](CardLocation loc) -> std::string {
        switch (loc) {
            case CardLocation::hand: return "hand";
            case CardLocation::table: return "table";
            case CardLocation::pocket: return "pocket";
            default: return "unknown";
        }
    };
    auto faceToString = [](CardFaceDirection face) -> std::string {
        switch (face) {
            case CardFaceDirection::up: return "up";
            case CardFaceDirection::down: return "down";
            default: return "unknown";
        }
    };

    j = json{
        {"id", card.id},
        {"value", card.value},
        {"location", locationToString(card.location)},
        {"face", faceToString(card.face)}
    };
}


#endif
