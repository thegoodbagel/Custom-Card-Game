#include "GameWrapper.h"

Napi::Object GameWrapper::Init(Napi::Env env, Napi::Object exports) {
    // Defines JS class "newGame" that wraps the C++ Game class
    Napi::Function func = DefineClass(env, "newGame", {
        // Links C++ methods to JS methods
        InstanceMethod("getState", &GameWrapper::GetState),
        // InstanceMethod("drawCard", &GameWrapper::DrawCard),
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
// Example: 
// {
//   "drawPileSize": 42,
//   "hand": [
//     {"id": "3", "value": "4", "location": "hand", "face": "up"},
//     {"id": "7", "value": "8", "location": "hand", "face": "up"}
//     // ... cards in player's hand
//   ],
//   "otherPlayers": {
//     "playerId_2": {"handSize": 5},
//     "playerId_3": {"handSize": 3}
//   }
// }
Napi::Value GameWrapper::GetState(const Napi::CallbackInfo& info) {
    Napi::Env env = info.Env();
    std::string playerId = info[0].As<Napi::String>();
    return Napi::String::New(env, game.getState(playerId));
}

// Napi::Value GameWrapper::DrawCard(const Napi::CallbackInfo& info) {
//     Napi::Env env = info.Env();
//     std::string playerId = info[0].As<Napi::String>();
//     Card card = game.drawCard(playerId);

//     Napi::Object cardObj = Napi::Object::New(env);
//     cardObj.Set("id", card.id);
//     cardObj.Set("value", card.value);
//     cardObj.Set("imageFile", card.value + ".png");
//     cardObj.Set("location", "hand");
//     cardObj.Set("face", "up");

//     return cardObj;
// }

Napi::Object InitAll(Napi::Env env, Napi::Object exports) {
    return GameWrapper::Init(env, exports);
}

NODE_API_MODULE(addon, InitAll)
