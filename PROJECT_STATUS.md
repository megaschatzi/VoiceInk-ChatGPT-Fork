# Project status

Updated: 2026-11-06 UTC. Read with `AGENTS.md`; use Actions for live build status.

## Current baseline

- Public fork: [megaschatzi/VoiceInk-ChatGPT-Fork](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork), parent `Beingpax/VoiceInk`, default branch `main`.
- Upstream merged: `14f2c8f8faafb6c178d0823bf87cda92c622d78a`, VoiceInk **2.25**, upstream build **225**. See `UPSTREAM.json`.
- Target release: **VoiceInk 2.25 — ChatGPT Build 228**. It is not yet verified or published. Preserve the legacy repository and existing release URLs.
- Separate app: `VoiceInk ChatGPT.app`, bundle ID `com.megaschatzi.VoiceInk.ChatGPT`. Preserve its existing Keychain namespace and data directories; keep original VoiceInk independent.
- Native ChatGPT login supports experimental audio transcription and text enhancement without an API key or installed CLI. Per-mode model/reasoning settings and custom model IDs are supported; CLI enhancement remains available.

## Validation and delivery

- Passed on native Apple Silicon: 31 protocol tests, mode-settings migration/backup round trips and native-client typechecking.
- The full app's updated MLX dependencies require **Swift 6.3+**. CI selects **Xcode 26.6 on macOS 26** and checks the compiler before building. The full app build and package verification remain outstanding.
- Independent packaging and upstream merge reviews found no remaining concrete blocker. Live app compilation and package checks are still required.
- Release packaging verifies the extracted ZIP and mounted DMG, app identity/version and signatures. Publication uploads complete DMG, ZIP, checksums and source provenance before making a release visible.
- Downloads and version details belong in GitHub Releases. README installation guidance stays general.
- New agent commits use **Spezi (Codex)**. Existing commits and upstream attribution remain unchanged. Keep commits focused on lasting changes; temporary build progress belongs in Actions or local notes.

## Next milestone

Complete the [macOS workflow](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/actions/workflows/chatgpt-macos.yml), verify the public release assets and manifest, then record the published release here. No automatic upstream merge is configured; future upstream updates require compatibility review and a new verified build.

Keep private operations, credentials, business prompts, personal dictionaries and recordings out of this public repository.
