# MediasoupClient.Net

mediasoup client side C# binding based on libmediasoupclient

## How to build release-x64 on Windows

* build `libwebrtc`
  
  Since the `libmediasoupclient` deps on `libwebrtc`, you need to build `libwebrtc` before configuring cmake.

  1. Make sure you have all submodules inited. Folder `deps\webrtc-builds` shouldn't be empty.
  2. Follow the [README.md](https://github.com/sourcey/webrtc-builds/blob/master/README.md) to build the webrtc. **NOTICE: libmediasoupclient deps on libwebrtc version m97. So you need to execute `./build.sh -c x64 -b branch-heads/4606` which corresponding to m97**
  
  If everything OK, you'll see a **beautiful** `deps\webrtc-builds\out\webrtc-xxxxx-xxxxxxx-win-x64` containing webrtc headers and libs.

  ### Trouble shooting
  * `ninja: line 8: exec: python3: not found`
  
    Create a file named `python3` at `deps\webrtc-builds\depot_tools` and enter following script in it.
    ```
    #!/usr/bin/env bash

    DEPOT_TOOLS=$(dirname "$0")/..
    PYTHON3_BIN_DIR="$DEPOT_TOOLS/depot_tools/bootstrap-2@3_8_10_chromium_26_bin/python3/bin"
    PATH="$PYTHON3_BIN_DIR":"$PYTHON3_BIN_DIR/Scripts":"$PATH"
    "$PYTHON3_BIN_DIR/python3" "$@"
    ```

    **NOTICE: After executing `./build.sh` it will reset the `deps\webrtc-builds\depot_tools` folder, so you must create this file AFTER reset and BEFORE compile.**


* build `libmediasoupclient`
  
  1. Back to the project root directory and configure cmake. set `LIBWEBRTC_LIB_PATH` to `.\deps\webrtc-builds\out\webrtc-xxxxx-xxxxxxx-win-x64\lib\x64\Release\libwebrtc_full.lib` and set `LIBWEBRTC_INCLUDE_PATH` to `.\deps\webrtc-builds\out\webrtc-xxxxx-xxxxxxx-win-x64\include` for a win-x64 release build.
  2. Open the generated `mediasoupclient.sln` in Visual Studio and build `ZERO_CHECK`, `sdptransform` and `mediasoupclient` one by one.

  ### Trouble shooting
  * `fatal  error C1083: Cannot open include file: 'absl/base/attributes.h': No such file or directory`
  
    Copy `deps\webrtc-builds\out\src\third_party\abseil-cpp` to `deps\webrtc-builds\out\webrtc-xxxxx-xxxxxxx-win-x64\include\third_party\abseil-cpp`


----


# libmediasoupclient

C++ client side library for building [mediasoup][mediasoup-website] based applications built on top of Google's libwebrtc C++ library.



## Website and Documentation

* [mediasoup.org][mediasoup-website]


## Support Forum

* [mediasoup.discourse.group][mediasoup-discourse]


## Authors

* José Luis Millán [[website](https://jssip.net)|[github](https://github.com/jmillan/)]
* Iñaki Baz Castillo [[website](https://inakibaz.me)|[github](https://github.com/ibc/)]



## License

[ISC](./LICENSE)




[mediasoup-website]: https://mediasoup.org
[mediasoup-discourse]: https://mediasoup.discourse.group
