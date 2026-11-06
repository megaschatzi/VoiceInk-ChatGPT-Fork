# Project status

Updated: 2026-11-06 UTC. Read with `AGENTS.md`; use Actions for live build status.

## Current baseline

- Public fork: [megaschatzi/VoiceInk-ChatGPT-Fork](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork), parent `Beingpax/VoiceInk`, default branch `main`.
- Upstream merged: `14f2c8f8faafb6c178d0823bf87cda92c622d78a`, VoiceInk **2.25**, upstream build **225**. See `UPSTREAM.json`.
- Published: **[VoiceInk 2.25 — ChatGPT Build 228](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/releases/tag/v2.25-chatgpt-build228)**, source `8b10d4e7800d848b39c73d52f202dbb0a1a5051e`. Preserve the legacy repository and existing release URLs.
- Separate app: `VoiceInk ChatGPT.app`, bundle ID `com.megaschatzi.VoiceInk.ChatGPT`. Preserve its existing Keychain namespace and data directories; keep original VoiceInk independent.
- Native ChatGPT login supports experimental audio transcription and text enhancement without an API key or installed CLI. Per-mode model/reasoning settings and custom model IDs are supported; CLI enhancement remains available.

## Validation and delivery

- Passed on native Apple Silicon: 31 protocol tests, mode-settings migration/backup round trips, native-client typechecking and the full app build. Verified [release workflow](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/actions/runs/42289949191).
- The updated MLX dependencies require **Swift 6.3+**. The successful build used **Xcode 26.6 / Swift 6.3.3 on macOS 26**.
- ZIP and DMG were signed and verified in CI. Both published downloads were retrieved without a login, their checksums and manifest matched, and the ZIP contained bundle `com.megaschatzi.VoiceInk.ChatGPT`, version `2.25`, build `228`, minimum macOS `15.0`, with an `arm64` executable. Signing is ad hoc, not Apple notarization.
- Independent packaging and upstream merge reviews were completed. No live ChatGPT account was used in CI; user testing on a Mac remains the runtime confirmation.
- Release packaging verifies the extracted ZIP and mounted DMG, app identity/version and signatures. Publication uploads complete DMG, ZIP, checksums and source provenance before making a release visible.
- Downloads and version details belong in GitHub Releases. README installation guidance stays general.
- New agent commits use **Spezi (Codex)**. Existing commits and upstream attribution remain unchanged. Keep commits focused on lasting changes; temporary build progress belongs in Actions or local notes.
- At the user's request, redundant migration progress commits were consolidated after a verified recoverable backup. The final file tree, upstream merge and earlier feature history were preserved. Do not rewrite the published release commit/tag.

## Future work

Future upstream updates require a review branch, compatibility checks and a new verified release. No automatic upstream merge is configured. Increment the existing ChatGPT build counter for the next app release; keep downloads in GitHub Releases and update this handoff at delivery milestones.

Keep private operations, credentials, business prompts, personal dictionaries and recordings out of this public repository.
