#!/bin/bash
set -e

export CI=true

echo "Downloading Flutter SDK 3.24.5..."

curl -fL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz -o /tmp/flutter.tar.xz

tar -xf /tmp/flutter.tar.xz -C /tmp

export PATH="/tmp/flutter/bin:$PATH"

flutter config --enable-web

flutter precache --web

flutter pub get

flutter build web --release
