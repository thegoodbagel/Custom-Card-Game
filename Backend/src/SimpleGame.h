#ifndef SIMPLE_GAME_H
#define SIMPLE_GAME_H

#include <unordered_set>
#include <DeckType.h>
#include <Player.h>

class SimpleGame {
    public:
        DeckType deck;
        SimpleGame(DeckType deck);
        std::string getState(std::string playerID);
        Card drawCard(std::string playerID);
        void addPlayer(std::string playerID);
    private:
        std::unordered_map<std::string, std::unique_ptr<Player>> players;
        std::vector<Card> drawPile;
};

#endif
