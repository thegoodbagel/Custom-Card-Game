{
  "targets": [
    {
      "target_name": "addon",
      "sources": [ "src/binding.cc", "src/GameLogic.cpp" ],
      "include_dirs": [
        "<!(node -p 'require(\"node-addon-api\").include.replace(/\"/g, \"\")')"
      ],
      "dependencies": [
        "<!(node -p \"require('node-addon-api').gyp\")"
      ],
      "cflags_cc!": [ "-fno-exceptions" ],
      "cflags_cc": [ "-std=c++17" ],
      "defines": [ "NAPI_CPP_EXCEPTIONS" ],
      "conditions": [
        [ "OS=='mac'", {
          "xcode_settings": {
            "MACOSX_DEPLOYMENT_TARGET": "10.15"
          }
        }]
      ]
    }
  ]
}
