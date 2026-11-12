# Project status

Updated: 2026-11-12 (Europe/Berlin). Read with `AGENTS.md`; use Actions for live build status.

## Current baseline

- Public fork: [megaschatzi/VoiceInk-ChatGPT-Fork](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork), parent `Beingpax/VoiceInk`, default branch `main`.
- Upstream merged: `b5d1be9a7c7377dd059f37bb3e0f791b802d4001`, VoiceInk **2.27**, upstream build **227**. See `UPSTREAM.json`.
- Published: **[VoiceInk 2.27 — ChatGPT Build 230](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/releases/tag/v2.27-chatgpt-build230)**, source `664f5904c06f4dc754d7d1e5b43323210aa25d47`. Preserve the legacy repository and existing release URLs.
- The legacy repository's main branch is now a short link-only landing page plus its license. Earlier history, branches and releases remain available; active development belongs in this fork.
- Separate app: `VoiceInk ChatGPT.app`, bundle ID `com.megaschatzi.VoiceInk.ChatGPT`. Preserve its existing Keychain namespace and data directories; keep original VoiceInk independent.
- Native ChatGPT login supports experimental audio transcription and text enhancement without an API key or installed CLI. Per-mode model/reasoning settings and custom model IDs are supported; CLI enhancement remains available.

## Latest release

VoiceInk **2.27 — ChatGPT Build 230** integrates the exact stable upstream 2.27 tag: ElevenLabs Scribe V3, display wake prevention during active dictation and performance improvements. Native ChatGPT audio/text integration, custom models/reasoning, settings and separate app identity remain intact. A fork fix serializes API-key presence lookup and writes/deletes; transient Keychain failures remain uncached. The regression passes with the fix and fails against unmodified upstream, using a mock Keychain without credentials.

Independent merge/cache and release-source reviews found no blocker. Review validation passed ([run 43167075878](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/actions/runs/43167075878)); the final source was rebuilt and published by [run 43168863938](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/actions/runs/43168863938). The release tag resolves to `664f5904c06f4dc754d7d1e5b43323210aa25d47`. Later documentation commits do not change that binary provenance.

## Validation and delivery

- Passed on native Apple Silicon: 31 protocol/client tests, mode-settings migration/backup round trips, API-key cache concurrency tests, native-client/API-key-manager typechecking and the full app build. Verified [release workflow](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/actions/runs/43168863938).
- The updated MLX dependencies require **Swift 6.3+**. The successful build used **Xcode 26.6 / Swift 6.3.3 on macOS 26**.
- ZIP and DMG were signed and verified in CI. Both published downloads were retrieved without a login; package sizes, SHA-256 hashes, exact source/upstream manifest and release tag matched. The extracted ZIP and mounted DMG contained bundle `com.megaschatzi.VoiceInk.ChatGPT`, version `2.27`, build `230`, minimum macOS `15.0`, and an `arm64` executable. Both app signatures and the DMG signature passed; the DMG also contained the Applications shortcut and matching license. Signing is ad hoc, not Apple notarization.
- Independent packaging and upstream merge reviews were completed. No live ChatGPT account was used in CI; user testing on a Mac remains the runtime confirmation.
- Release packaging verifies the extracted ZIP and mounted DMG, app identity/version and signatures. Publication uploads complete DMG, ZIP, checksums and source provenance before making a release visible.
- Downloads and version details belong in GitHub Releases. README installation guidance stays general.
- The setup guide includes three real captures of released Build 228: ChatGPT sign-in, ChatGPT Dictation selection, and text model/reasoning selection. Selection examples use clearly labeled disposable demo settings, without a real account or service request. Full app screenshots use simple orange frames around the sign-in button, transcription model, and enhancement settings, without zoomed details or arrows. Original dimensions and all pixels outside the frame outlines are preserved; the three final images were visually checked. Documentation images do not trigger an app rebuild.
- Build 230 is a regular release marked **Latest**; future releases are marked latest after all assets upload. The experimental nature of the ChatGPT integration remains documented.
- New agent commits use **Spezi (Codex)**. Existing commits and upstream attribution remain unchanged. Keep commits focused on lasting changes; temporary build progress belongs in Actions or local notes.
- At the user's request, redundant migration progress commits were consolidated after a verified recoverable backup. The final file tree, upstream merge and earlier feature history were preserved. Do not rewrite the published release commit/tag.

## Future work

Future upstream updates require a review branch, compatibility checks and a new verified release. No automatic upstream merge is configured. The next unused ChatGPT build is **231** at this delivery; recheck releases before use. Increment the existing ChatGPT build counter for the next app release; keep downloads in GitHub Releases and update this handoff at delivery milestones.

Keep private operations, credentials, business prompts, personal dictionaries and recordings out of this public repository.

## Agent handoff

`AGENTS.md` provides the startup reading order and maintenance rules. The integration, build/release guide, changelog and upstream metadata are tracked here, so a new agent can resume from a fresh checkout without the previous conversation or workspace. Keep release tags authoritative for binary provenance; `main` may contain later documentation. Personal prompts, dictionaries and app credentials are outside this source repository.

## Upstream feature proposal

The user submitted [Beingpax/VoiceInk#1063](https://github.com/Beingpax/VoiceInk/issues/1063): **Native ChatGPT sign-in for audio transcription and text enhancement (no API key or CLI)**. It links this fork, implementation details, the release and three setup screenshots. It is a feature suggestion, not a pull request, in line with upstream's current contribution policy. Verified open with no comments on 2026-11-12; check the issue directly for later maintainer feedback before planning an upstream contribution. No automatic issue monitoring is configured.

## Integrated upstream and handoff

Stable upstream **2.27**, published 2026-11-11, is integrated at `b5d1be9a7c7377dd059f37bb3e0f791b802d4001`. Its Keychain existence change, API-key cache, app/engine observation and recorder sleep behavior were reviewed against our separate identity/account lifecycle. Existing custom modes and reasoning settings passed migration/backup checks. No real ChatGPT account, audio, microphone or live provider request was used in CI; sign-in/dictation/enhancement and hardware behavior still need user runtime confirmation.

`AGENT_HANDOFF.md` provides the standalone runbook. The previous [Build 229](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/releases/tag/v2.26-chatgpt-build229) and legacy release URLs remain intact. Do not overwrite published packages or tags.
