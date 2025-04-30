#!/bin/bash

LOVE_VERSION="11.5"
BASE_URL="https://github.com/love2d/love/releases/download/${LOVE_VERSION}"

mkdir -p downloads
cd downloads || exit 1

# Download Windows
if [ ! -f love-${LOVE_VERSION}-win64.zip ]; then
    echo ">> Downloading LÖVE for Windows..."
    curl -LO "${BASE_URL}/love-${LOVE_VERSION}-win64.zip"
    unzip -q "love-${LOVE_VERSION}-win64.zip" -d "../love-${LOVE_VERSION}-win64"
fi

# Download Linux
# if [ ! -f love-${LOVE_VERSION}-linux-x86_64.tar.gz ]; then
#     echo ">> Downloading LÖVE for Linux..."
#     curl -LO "${BASE_URL}/love-${LOVE_VERSION}-linux-x86_64.tar.gz"
#     mkdir -p ../love-${LOVE_VERSION}-linux-x86_64
#     tar -xzf "love-${LOVE_VERSION}-linux-x86_64.tar.gz" -C "../love-${LOVE_VERSION}-linux-x86_64" --strip-components=1
# fi

# Download macOS
if [ ! -f love-${LOVE_VERSION}-macos.zip ]; then
    echo ">> Downloading LÖVE for macOS..."
    curl -LO "${BASE_URL}/love-${LOVE_VERSION}-macos.zip"
    unzip -q "love-${LOVE_VERSION}-macos.zip" -d "../love-${LOVE_VERSION}-macos"
fi

echo "Done! All LÖVE versions downloaded and extracted!"
