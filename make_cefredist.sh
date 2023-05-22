#!/bin/bash
TMP="tmp"
OUTPUT="../package"
if [ ! -d "$TMP" ]; then
    mkdir "$TMP"
fi
cd "$TMP" || exit 1
rm -rf "$OUTPUT"
mkdir "$OUTPUT"
mkdir "$OUTPUT/CEF"
mkdir "$OUTPUT/CEF/Resources"
CEFZIP="cef.tar.bz2"
CEFBINARIES="cef_binaries"
if [ ! -f "$CEFZIP" ]; then
    echo "downloading cef binaries"
    curl -o "$CEFZIP" "https://cef-builds.spotifycdn.com/cef_binary_106.0.26%2Bge105400%2Bchromium-106.0.5249.91_linux64_minimal.tar.bz2"
fi
if [ ! -d "$CEFBINARIES" ]; then
    echo "unzipping cef binaries"
    mkdir "$CEFBINARIES"
    tar -jxvf "$CEFZIP" -C "./$CEFBINARIES"
fi
echo "copying cef binaries"
cp -va "${PWD}/$(find $CEFBINARIES -name "Release")/." "$OUTPUT/CEF/"
cd .. || exit 1
echo "stripping cef binaries"
strip -v -s "package/CEF/libcef.so"
strip -v -s "package/CEF/libEGL.so"
strip -v -s "package/CEF/libGLESv2.so"
strip -v -s "package/CEF/libvk_swiftshader.so"
strip -v -s "package/CEF/libvulkan.so.1"
cd "$TMP" || exit 1
cp -Rv "${PWD}/$(find $CEFBINARIES -name "Resources")/" "$OUTPUT/CEF/"
cd ..