#include <napi.h>
#include "SimpleGame.h"

SimpleGame game;

Napi::String GetState(const Napi::CallbackInfo& info) {
    Napi::Env env = info.Env();
    std::string playerId = info[0].As<Napi::String>();
    return Napi::String::New(env, game.getState(playerId));
}

Napi::Value drawCard(const Napi::CallbackInfo& info) {
    Napi::Env env = info.Env();

    std::string playerId = info[0].As<Napi::String>();
    Card card = game.drawCard(playerId); // You'll need to implement this

    Napi::Object cardObj = Napi::Object::New(env);
    cardObj.Set("id", card.id); // Assuming card.id is a string
    cardObj.Set("value", card.value);
    cardObj.Set("imageFile", card.value + ".png"); // or card.imageFile if available
    cardObj.Set("location", "hand");
    cardObj.Set("face", "up");

    return cardObj;
}

void addPlayer(const Napi::CallbackInfo& info) {
    std::string id = info[0].As<Napi::String>();
    game.addPlayer(id);
}

Napi::Object Init(Napi::Env env, Napi::Object exports) {
    exports.Set("getState", Napi::Function::New(env, GetState));
    exports.Set("drawCard", Napi::Function::New(env, drawCard));
    exports.Set("addPlayer", Napi::Function::New(env, addPlayer));
    return exports;
}

NODE_API_MODULE(addon, Init)
