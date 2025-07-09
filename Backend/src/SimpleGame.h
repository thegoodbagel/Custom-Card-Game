#ifndef SIMPLE_GAME_H
#define SIMPLE_GAME_H

#include <unordered_set>
#include "Player.h"
#include "Standard52Deck.h"

class SimpleGame {
    public:
        SimpleGame();
        std::vector<Standard52Deck> deckType;
        std::string getState(std::string playerID);
        std::optional<Card> drawCard(std::string playerID);
        void playCard(std::string playerID, std::string cardID);
        void addPlayer(std::string playerID);
        void removePlayer(std::string playerID);

    private:
        std::unordered_map<std::string, std::unique_ptr<Player>> players;
        std::vector<Card> drawPile;
        std::vector<Card> discardPile;
        std::vector<Card> playPile;
};

#endif
