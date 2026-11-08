#!/bin/bash
set -e

export CI=true
FLUTTER_VERSION="3.24.5"

echo "Cloning Flutter ${FLUTTER_VERSION}..."
git clone --depth 1 --branch "${FLUTTER_VERSION}" https://github.com/flutter/flutter.git /tmp/flutter

# Tránh lỗi "detected dubious ownership" khi Flutter gọi git
git config --global --add safe.directory /tmp/flutter

export PATH="/tmp/flutter/bin:$PATH"

flutter config --no-analytics --enable-web
flutter precache --web
flutter pub get

flutter build web --release --base-href /
