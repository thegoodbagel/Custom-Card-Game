#include "GameWrapper.h"

Napi::Object GameWrapper::Init(Napi::Env env, Napi::Object exports) {
    // Defines JS class "newGame" that wraps the C++ Game class
    Napi::Function func = DefineClass(env, "newGame", {
        // Links C++ methods to JS methods
        InstanceMethod("getState", &GameWrapper::GetState),
        InstanceMethod("drawCard", &GameWrapper::DrawCard),
        InstanceMethod("playCard", &GameWrapper::PlayCard),
        InstanceMethod("addPlayer", &GameWrapper::AddPlayer)
    });
    // JS constructor for the GameWrapper class
    exports.Set("newGame", func);
    return exports;
}

// Constructor for the GameWrapper class
GameWrapper::GameWrapper(const Napi::CallbackInfo& info)
    : Napi::ObjectWrap<GameWrapper>(info), game() {
}

void GameWrapper::AddPlayer(const Napi::CallbackInfo& info) {
    std::string id = info[0].As<Napi::String>();
    game.addPlayer(id);
}

// One argument: string of player ID (socket ID)
// Returns the game state JSON string from the perspective of the player
Napi::Value GameWrapper::GetState(const Napi::CallbackInfo& info) {
    Napi::Env env = info.Env();
    std::string playerId = info[0].As<Napi::String>();
    return Napi::String::New(env, game.getState(playerId));
}

void GameWrapper::DrawCard(const Napi::CallbackInfo& info) {
    Napi::Env env = info.Env();
    std::string playerId = info[0].As<Napi::String>();
    game.drawCard(playerId);
}

void GameWrapper::PlayCard(const Napi::CallbackInfo& info) {
    Napi::Env env = info.Env();
    std::string playerId = info[0].As<Napi::String>();
    std::string cardId = info[1].As<Napi::String>();
    game.playCard(playerId, cardId);
}

Napi::Object InitAll(Napi::Env env, Napi::Object exports) {
    return GameWrapper::Init(env, exports);
}

NODE_API_MODULE(addon, InitAll)
