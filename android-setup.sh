#!/usr/bin/env bash
# يتنفذ ف GitHub Actions بعد "npx cap add android"
set -euo pipefail

PKG_DIR="android/app/src/main/java/dz/alscif/carburant"
MANIFEST="android/app/src/main/AndroidManifest.xml"

# 1) الطباعة الأصلية (PDF A4)
mkdir -p "$PKG_DIR"
cp android-overrides/MainActivity.java android-overrides/NativePrintPlugin.java "$PKG_DIR/"

# 2) صلاحية الكاميرا (تصوير الوصل)
if ! grep -q "android.permission.CAMERA" "$MANIFEST"; then
  sed -i 's#<application#<uses-permission android:name="android.permission.CAMERA" />\n    <uses-feature android:name="android.hardware.camera" android:required="false" />\n    <application#' "$MANIFEST"
fi

echo "Android overrides applied."
