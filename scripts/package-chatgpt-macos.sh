#!/usr/bin/env bash
set -euo pipefail
app=${1:?Usage: package-chatgpt-macos.sh APP OUTPUT_DIRECTORY}
output=${2:?Usage: package-chatgpt-macos.sh APP OUTPUT_DIRECTORY}
repo_root=$(cd "$(dirname "$0")/.." && pwd)
plist="$app/Contents/Info.plist"
version=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$plist")
build=$(/usr/libexec/PlistBuddy -c 'Print CFBundleVersion' "$plist")
bundle_id=$(/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' "$plist")
[[ "$version" =~ ^[0-9]+(\.[0-9]+){1,2}$ && "$build" =~ ^[0-9]+$ ]]
[[ "$bundle_id" == com.megaschatzi.VoiceInk.ChatGPT ]]
codesign --verify --deep --strict "$app"
mkdir -p "$output"
output=$(cd "$output" && pwd)
name="VoiceInk-${version}-ChatGPT-Build-${build}"
staging=$(mktemp -d -t voiceink-package)
trap 'rm -rf "$staging"' EXIT
ditto "$app" "$staging/VoiceInk ChatGPT.app"
ln -s /Applications "$staging/Applications"
cp "$repo_root/LICENSE" "$staging/LICENSE.txt"
ditto -c -k --sequesterRsrc --keepParent "$app" "$output/$name.zip"
zip_check="$staging/zip-check"
mkdir "$zip_check"
ditto -x -k "$output/$name.zip" "$zip_check"
zip_app="$zip_check/VoiceInk ChatGPT.app"
[[ $(/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' "$zip_app/Contents/Info.plist") == "$bundle_id" ]]
[[ $(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$zip_app/Contents/Info.plist") == "$version" ]]
[[ $(/usr/libexec/PlistBuddy -c 'Print CFBundleVersion' "$zip_app/Contents/Info.plist") == "$build" ]]
codesign --verify --deep --strict "$zip_app"
rm -rf "$zip_check"
hdiutil create -volname "VoiceInk $version ChatGPT $build" -srcfolder "$staging" -format UDZO -ov "$output/$name.dmg"
codesign --force --sign - "$output/$name.dmg"
codesign --verify --strict "$output/$name.dmg"
# Inspect the actual DMG, including the install shortcut and app identity.
mount="$staging/mounted"
mkdir "$mount"
hdiutil attach "$output/$name.dmg" -readonly -nobrowse -mountpoint "$mount"
trap 'hdiutil detach "$mount" >/dev/null 2>&1 || true; rm -rf "$staging"' EXIT
[[ $(readlink "$mount/Applications") == /Applications ]]
[[ $(/usr/libexec/PlistBuddy -c 'Print CFBundleVersion' "$mount/VoiceInk ChatGPT.app/Contents/Info.plist") == "$build" ]]
codesign --verify --deep --strict "$mount/VoiceInk ChatGPT.app"
hdiutil detach "$mount"
trap 'rm -rf "$staging"' EXIT
python3 "$repo_root/scripts/release-manifest.py" "$output" "$version" "$build"
(cd "$output" && shasum -a 256 "$name.zip" "$name.dmg" release-manifest.json > SHA256SUMS)
if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "build_number=$build" >> "$GITHUB_OUTPUT"
  echo "app_version=$version" >> "$GITHUB_OUTPUT"
fi
