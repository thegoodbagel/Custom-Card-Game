#include <napi.h>
// #include "GameLogic.h"

// GameLogic logic;

// Napi::String GetState(const Napi::CallbackInfo& info) {
//     Napi::Env env = info.Env();
//     return Napi::String::New(env, logic.getState());
// }

// void MakeMove(const Napi::CallbackInfo& info) {
//     Napi::Env env = info.Env();
//     std::string move = info[0].As<Napi::String>();
//     logic.makeMove(move);
// }

// Napi::Object Init(Napi::Env env, Napi::Object exports) {
//     exports.Set("getState", Napi::Function::New(env, GetState));
//     exports.Set("makeMove", Napi::Function::New(env, MakeMove));
//     return exports;
// }

// NODE_API_MODULE(addon, Init)
