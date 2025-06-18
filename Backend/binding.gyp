{
  "targets": [
    {
      "target_name": "addon",
      "sources": [ "src/binding.cc" ],
      "include_dirs": [
        "<!@(node -p \"require('node-addon-api').include\")"
      ],
      "dependencies": [
        "<!(node -p \"require('node-addon-api').gyp\")"
      ],
      "cflags_cc": [ "-fexceptions" ],
      "defines": [ "NAPI_CPP_EXCEPTIONS" ],
      "libraries": []
    }
  ]
}
