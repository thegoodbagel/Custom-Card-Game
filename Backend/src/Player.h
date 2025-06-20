#ifndef PLAYER_H
#define PLAYER_H

#include <SimpleGame.h>
#include <Card.h>

class Player {
    public:
        Player(std::string playerID);
        std::string getName();
        std::string getID();
        void addCardToHand(Card card);
        void removeCardFromHand(Card card);
        
    private:
        SimpleGame game;
        std::string id;
        std::string name;
        std::vector<Card> hand; 
};

#endif
