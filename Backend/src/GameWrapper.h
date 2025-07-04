#ifndef GAMEWRAPPER_H
#define GAMEWRAPPER_H

#include <napi.h>
#include "SimpleGame.h"

// Allows server to interact with game instance
class GameWrapper : public Napi::ObjectWrap<GameWrapper> {
public:
    // Create new game instance in JS with newGame() constructor
    static Napi::Object Init(Napi::Env env, Napi::Object exports);
    GameWrapper(const Napi::CallbackInfo& info);

private:
    void AddPlayer(const Napi::CallbackInfo& info);
    Napi::Value GetState(const Napi::CallbackInfo& info);
    Napi::Value DrawCard(const Napi::CallbackInfo& info);
    SimpleGame game;
};

#endif
