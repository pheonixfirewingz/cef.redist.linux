TMP="tmp"
OUTPUT="../package"
if [ ! -d "$TMP" ]; then
    mkdir "$TMP"
fi
cd "$TMP"
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
cp -v "${PWD}/$(find $CEFBINARIES -name "Release")/libcef.so" "$OUTPUT/CEF/libcef.so"
cp -Rv "${PWD}/$(find $CEFBINARIES -name "Resources")/" "$OUTPUT/CEF/"
cd ..