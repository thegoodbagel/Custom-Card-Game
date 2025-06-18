#include "GameLogic.h"

GameLogic::GameLogic() : state("initial") {}

std::string GameLogic::getState() {
    return state;
}

void GameLogic::makeMove(const std::string& move) {
    state += " -> " + move;
}
