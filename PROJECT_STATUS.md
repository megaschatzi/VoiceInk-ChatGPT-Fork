# Project status

Updated: 2026-11-07 UTC. Read with `AGENTS.md`; use Actions for live build status.

## Current baseline

- Public fork: [megaschatzi/VoiceInk-ChatGPT-Fork](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork), parent `Beingpax/VoiceInk`, default branch `main`.
- Upstream merged: `4bc74caddfad6fdfab71e5957451b83b33c1a2c5`, VoiceInk **2.26**, upstream build **226**. See `UPSTREAM.json`.
- Published: **[VoiceInk 2.26 — ChatGPT Build 229](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/releases/tag/v2.26-chatgpt-build229)**, source `750fdeb5b312a54dce412ecf4600631d92e75abd`. Preserve the legacy repository and existing release URLs.
- The legacy repository's main branch is now a short link-only landing page plus its license. Earlier history, branches and releases remain available; active development belongs in this fork.
- Separate app: `VoiceInk ChatGPT.app`, bundle ID `com.megaschatzi.VoiceInk.ChatGPT`. Preserve its existing Keychain namespace and data directories; keep original VoiceInk independent.
- Native ChatGPT login supports experimental audio transcription and text enhancement without an API key or installed CLI. Per-mode model/reasoning settings and custom model IDs are supported; CLI enhancement remains available.

## Latest release

VoiceInk **2.26 — ChatGPT Build 229** integrates the exact upstream release tag. Only version/build metadata, upstream release notes and its original packaging script changed after our previous base; the streaming fixes were already included. The separate ChatGPT app identity and runtime implementation are unchanged. Independent merge/packaging review found no blocker. Review-branch validation passed ([run 42360324482](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/actions/runs/42360324482)); the final source was built and published by the main-branch release workflow below.

## Validation and delivery

- Passed on native Apple Silicon: 31 protocol tests, mode-settings migration/backup round trips, native-client typechecking and the full app build. Verified [release workflow](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/actions/runs/42361416234).
- The updated MLX dependencies require **Swift 6.3+**. The successful build used **Xcode 26.6 / Swift 6.3.3 on macOS 26**.
- ZIP and DMG were signed and verified in CI. Both published downloads were retrieved without a login, their checksums and manifest matched, and the ZIP contained bundle `com.megaschatzi.VoiceInk.ChatGPT`, version `2.26`, build `229`, minimum macOS `15.0`, with an `arm64` executable. Signing is ad hoc, not Apple notarization.
- Independent packaging and upstream merge reviews were completed. No live ChatGPT account was used in CI; user testing on a Mac remains the runtime confirmation.
- Release packaging verifies the extracted ZIP and mounted DMG, app identity/version and signatures. Publication uploads complete DMG, ZIP, checksums and source provenance before making a release visible.
- Downloads and version details belong in GitHub Releases. README installation guidance stays general.
- The setup guide includes three real captures of released Build 228: ChatGPT sign-in, ChatGPT Dictation selection, and text model/reasoning selection. Selection examples use clearly labeled disposable demo settings, without a real account or service request. Full app screenshots use simple orange frames around the sign-in button, transcription model, and enhancement settings, without zoomed details or arrows. Original dimensions and all pixels outside the frame outlines are preserved; the three final images were visually checked. Documentation images do not trigger an app rebuild.
- Build 229 is a regular release marked **Latest**; future releases are marked latest after all assets upload. The experimental nature of the ChatGPT integration remains documented.
- New agent commits use **Spezi (Codex)**. Existing commits and upstream attribution remain unchanged. Keep commits focused on lasting changes; temporary build progress belongs in Actions or local notes.
- At the user's request, redundant migration progress commits were consolidated after a verified recoverable backup. The final file tree, upstream merge and earlier feature history were preserved. Do not rewrite the published release commit/tag.

## Future work

Future upstream updates require a review branch, compatibility checks and a new verified release. No automatic upstream merge is configured. Increment the existing ChatGPT build counter for the next app release; keep downloads in GitHub Releases and update this handoff at delivery milestones.

Keep private operations, credentials, business prompts, personal dictionaries and recordings out of this public repository.

## Agent handoff

`AGENTS.md` provides the startup reading order and maintenance rules. The integration, build/release guide, changelog and upstream metadata are tracked here, so a new agent can resume from a fresh checkout without the previous conversation or workspace. Keep release tags authoritative for binary provenance; `main` may contain later documentation. Personal prompts, dictionaries and app credentials are outside this source repository.

## Upstream feature proposal

The user submitted [Beingpax/VoiceInk#1063](https://github.com/Beingpax/VoiceInk/issues/1063): **Native ChatGPT sign-in for audio transcription and text enhancement (no API key or CLI)**. It links this fork, implementation details, the release and three setup screenshots. It is a feature suggestion, not a pull request, in line with upstream's current contribution policy. Verified open with no comments on 2026-11-07; check the issue directly for later maintainer feedback before planning an upstream contribution. No automatic issue monitoring is configured.
