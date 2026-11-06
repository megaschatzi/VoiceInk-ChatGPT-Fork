# Build and release

## Local build

Requires macOS, Xcode with Swift 6.3+ (the updated MLX dependencies require it), CMake and Python 3.11+ for packaging. CI uses the standard Apple Silicon macOS 26 image with Xcode 26.6.

```sh
swift test
python3 scripts/test-chatgpt-mode-settings.py
bash scripts/build-whisper-macos.sh
make local LOCAL_CODESIGN_IDENTITY=-
bash scripts/package-chatgpt-macos.sh "$HOME/Downloads/VoiceInk ChatGPT.app" dist
```

The app is copied to `~/Downloads/VoiceInk ChatGPT.app`. Packages are written to `dist/`.

## Releases

Run **VoiceInk ChatGPT macOS** with **publish_release** enabled, or push a release commit containing `[release]` to `main`.

The workflow tests the native protocol and settings migration, builds the app, checks its signature, mounts and checks the DMG, then publishes DMG, ZIP, SHA256SUMS and a source manifest. Naming: **VoiceInk 2.25 — ChatGPT Build 228**. The base version and ChatGPT build are independent; the build counter always increases.

## Upstream updates

Merge upstream changes into a review branch, resolve conflicts and run the build before updating `main`. Update `UPSTREAM.json` to the exact base commit/version/build. Never overwrite the fork with a forced sync.

The ChatGPT app identifier, Keychain namespace and storage directories must stay unchanged across updates. Its original VoiceInk updater is disabled. No ChatGPT tokens or audio files are used in CI.

[Install/update the app](README.md#-install-or-update)
