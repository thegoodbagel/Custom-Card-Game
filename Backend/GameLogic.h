#ifndef GAME_LOGIC_H
#define GAME_LOGIC_H

#include <string>

class GameLogic {
public:
    GameLogic();
    std::string getState();
    void makeMove(const std::string& move);
private:
    std::string state;
};

#endif
