{
  "targets": [
    {
      "target_name": "addon",
      "sources": [
        "src/GameWrapper.cpp",
        "src/SimpleGame.cpp",
        "src/Player.cpp",
      ],
      "include_dirs": [
        "<!@(node -p \"require('node-addon-api').include\")"
      ],
      "dependencies": [
        "<!(node -p \"require('node-addon-api').gyp\")"
      ],
      "cflags_cc": [ "-fexceptions" ],
      "defines": [ "NAPI_DISABLE_CPP_EXCEPTIONS=0" ]
    }
  ]
}
