# Changelog

## VoiceInk 2.27 — ChatGPT Build 230 · 2026-11-12

- 🔄 Integrated stable upstream 2.27: ElevenLabs Scribe V3, display wake prevention during dictation and performance improvements.
- 🔒 Preserved native ChatGPT audio/text integration, separate app identity and existing settings.
- 🛠️ Serialized API-key presence caching with key writes so a concurrent lookup cannot retain stale account availability. Transient Keychain failures remain uncached.

Upstream: `Beingpax/VoiceInk` · `b5d1be9a7c7377dd059f37bb3e0f791b802d4001` · version 2.27, build 227.

## Documentation · 2026-11-12

- 📝 Added a complete agent handoff, sub-agent workflow and next-upstream build/release checklist.

## VoiceInk 2.26 — ChatGPT Build 229 · 2026-11-07

- 🔄 Aligned with upstream VoiceInk 2.26; its streaming fixes were already included in Build 228.
- 🔒 Preserved ChatGPT features, app identity and existing settings.

Upstream: `Beingpax/VoiceInk` · `4bc74caddfad6fdfab71e5957451b83b33c1a2c5` · version 2.26, build 226.

## Documentation · 2026-11-06

- 🖼️ Added three full app screenshots with simple frames highlighting sign-in, transcription and model/reasoning controls.

## VoiceInk 2.25 — ChatGPT Build 228 · 2026-11-06

- 🔄 Moved development to a real upstream fork and merged the latest streaming, recorder-placement and dependency updates.
- 📦 Added versioned DMG/ZIP packages, checksums and source provenance.
- 📝 Shortened English documentation; kept app identity, settings and ChatGPT features intact.

Upstream: `Beingpax/VoiceInk` · `14f2c8f8faafb6c178d0823bf87cda92c622d78a` · version 2.25, build 225.

## VoiceInk 2.25 — ChatGPT Build 227

- ✨ Added per-mode models/reasoning, custom model IDs and language guidance.
- 🧪 Added request-payload and settings migration checks.

## VoiceInk 2.25 — ChatGPT Build 226

- 🎙️ Native ChatGPT sign-in, audio transcription and optional text enhancement.
- 🛠️ Fixed SSE parsing and responses without Content-Type.

[Previous releases](https://github.com/megaschatzi/VoiceInk-ChatGPT/releases) remain available at their original URLs.
