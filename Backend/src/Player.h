#ifndef PLAYER_H
#define PLAYER_H

#include "Card.h"

class Player {
    public:
        Player(std::string playerID);
        std::string getName();
        std::string getID();
        void addCardToHand(Card card);
        void removeCardFromHand(Card card);
        // Return copy of hand
        std::vector<Card> getHand() const { return hand; }
        int getHandSize() const { return hand.size(); }
        
    private:
        std::string id;
        std::string name;
        std::vector<Card> hand; 
};

#endif
