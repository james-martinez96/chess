#!/bin/bash

# --- Config ---
GAME_NAME="chess"
LOVE_VERSION="11.5"

LOVE_WINDOWS_DIR="./love-${LOVE_VERSION}-win64"
LOVE_LINUX_DIR="./love-${LOVE_VERSION}-linux-x86_64"
LOVE_MAC_DIR="./love-${LOVE_VERSION}-macos"

SRCDIR="./src"
BUILD_DIR="./build"
LOVE_FILE="${BUILD_DIR}/${GAME_NAME}.love"

# --- Helpers ---
mkdir -p "$BUILD_DIR"

echo ">> Creating .love file..."
rm -f "$LOVE_FILE"
# zip -9 -r "$LOVE_FILE" . -x "*.git*" "*__pycache__*" "*.DS_Store*" "build/*"
(cd $SRCDIR && zip -9 -r "../$LOVE_FILE" "." && cd ..)

# --- Windows Build ---
echo ">> Building Windows version..."
WIN_DIR="${BUILD_DIR}/${GAME_NAME}-windows"
mkdir -p "$WIN_DIR"
cat "${LOVE_WINDOWS_DIR}/love.exe" "$LOVE_FILE" > "${WIN_DIR}/${GAME_NAME}.exe"
cp "${LOVE_WINDOWS_DIR}/"*.dll "$WIN_DIR/"
cp "${LOVE_WINDOWS_DIR}/license.txt" "$WIN_DIR/"
(cd "$BUILD_DIR" && zip -r "${GAME_NAME}-windows.zip" "${GAME_NAME}-windows")

# --- Linux Build ---
# echo ">> Building Linux version..."
# LINUX_DIR="${BUILD_DIR}/${GAME_NAME}-linux"
# mkdir -p "$LINUX_DIR"
# cp "${LOVE_LINUX_DIR}/"love "${LINUX_DIR}/${GAME_NAME}"
# cp -r "${LOVE_LINUX_DIR}/"*.so* "$LINUX_DIR/"
# cp "$LOVE_FILE" "$LINUX_DIR/"
# chmod +x "${LINUX_DIR}/${GAME_NAME}"
# (cd "$BUILD_DIR" && zip -r "${GAME_NAME}-linux.zip" "${GAME_NAME}-linux")

# --- macOS Build ---
# echo ">> Building macOS version..."
# MAC_DIR="${BUILD_DIR}/${GAME_NAME}-macos"
# mkdir -p "$MAC_DIR"
# cp -r "${LOVE_MAC_DIR}/"love.app "$MAC_DIR/${GAME_NAME}.app"
# cp "$LOVE_FILE" "$MAC_DIR/${GAME_NAME}.app/Contents/Resources/${GAME_NAME}.love"
# (cd "$BUILD_DIR" && zip -r "${GAME_NAME}-macos.zip" "${GAME_NAME}-macos")

echo "Done! All builds completed! Find them in: $BUILD_DIR"
