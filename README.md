# VoiceInk ChatGPT

Native ChatGPT sign-in for **audio transcription and text enhancement**. No API key or installed CLI required. Based on [Beingpax/VoiceInk](https://github.com/Beingpax/VoiceInk), with separate app identity and storage so both apps can stay installed.

## ✨ Features

- Sign in with ChatGPT and transcribe recorded audio directly through ChatGPT.
- Optional text enhancement with per-mode model and reasoning selection.
- Current and earlier text-model presets, custom IDs, and model/language guidance.
- Separate settings, Keychain credentials, history and recordings from the original VoiceInk.

User-tested with **ChatGPT Plus and Pro ($100/month)**. Model access and usage limits depend on the account. This uses experimental internal endpoints; included audio minutes, billing treatment and continued availability are not guaranteed. Audio and enabled enhancement context are sent to OpenAI.

## 🚀 Install or update

Find downloads and version details in GitHub's **Releases** section. Requires macOS 15+. Ad-hoc signed, **not Apple-notarized**.

1. Quit **VoiceInk ChatGPT**. Open the DMG and drag the app to Applications, or unzip the ZIP and move the app there.
2. Replace the existing **VoiceInk ChatGPT.app** to keep its settings and data. The original **VoiceInk.app** remains separate.
3. If macOS blocks the app, use **System Settings → Privacy & Security** to approve it. Do not disable Gatekeeper.
4. Open **AI Models → Cloud → ChatGPT**, sign in and test the connection.
5. In a mode, choose **ChatGPT Dictation** and optionally enable **AI Enhancement → ChatGPT**. Select a text model and reasoning level.

To copy settings from the original app: export under **Settings → Backup**, then import in VoiceInk ChatGPT. History and account connections are not migrated. Run one dictation app at a time to avoid shortcut conflicts.

## 🛠️ Development

[Build instructions](CHATGPT-BUILD.md) · [Integration details](CHATGPT-INTEGRATION.md) · [Project status](PROJECT_STATUS.md) · [Changelog](CHANGELOG.md) · [Upstream provenance](UPSTREAM.json)

Original VoiceInk by its upstream authors. This fork is not an official OpenAI integration. Distributed under [GPL-3.0](LICENSE).
