#include <napi.h>
#include "SimpleGame.h"

class GameWrapper : public Napi::ObjectWrap<GameWrapper> {
public:
    static Napi::Object Init(Napi::Env env, Napi::Object exports);
    GameWrapper(const Napi::CallbackInfo& info);

private:
    Napi::Value GetState(const Napi::CallbackInfo& info);
    Napi::Value DrawCard(const Napi::CallbackInfo& info);
    void AddPlayer(const Napi::CallbackInfo& info);

    SimpleGame game_;
};


Napi::Object GameWrapper::Init(Napi::Env env, Napi::Object exports) {
    Napi::Function func = DefineClass(env, "newGame", {
        InstanceMethod("getState", &GameWrapper::GetState),
        InstanceMethod("drawCard", &GameWrapper::DrawCard),
        InstanceMethod("addPlayer", &GameWrapper::AddPlayer)
    });

    exports.Set("newGame", func);
    return exports;
}

GameWrapper::GameWrapper(const Napi::CallbackInfo& info)
    : Napi::ObjectWrap<GameWrapper>(info), game_() {
}

Napi::Value GameWrapper::GetState(const Napi::CallbackInfo& info) {
    Napi::Env env = info.Env();
    std::string playerId = info[0].As<Napi::String>();
    return Napi::String::New(env, game_.getState(playerId));
}

Napi::Value GameWrapper::DrawCard(const Napi::CallbackInfo& info) {
    Napi::Env env = info.Env();
    std::string playerId = info[0].As<Napi::String>();
    Card card = game_.drawCard(playerId);

    Napi::Object cardObj = Napi::Object::New(env);
    cardObj.Set("id", card.id);
    cardObj.Set("value", card.value);
    cardObj.Set("imageFile", card.value + ".png");
    cardObj.Set("location", "hand");
    cardObj.Set("face", "up");

    return cardObj;
}

void GameWrapper::AddPlayer(const Napi::CallbackInfo& info) {
    std::string id = info[0].As<Napi::String>();
    game_.addPlayer(id);
}
Napi::Object InitAll(Napi::Env env, Napi::Object exports) {
    return GameWrapper::Init(env, exports);
}

NODE_API_MODULE(addon, InitAll)
