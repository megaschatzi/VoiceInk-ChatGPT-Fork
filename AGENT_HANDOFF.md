# VoiceInk ChatGPT | Agent handoff

Verified: **2026-11-12, Europe/Berlin**. This is a standalone development and release handoff. See `PROJECT_STATUS.md` for current validation and publication evidence. Read current repository instructions and GitHub state before acting; dates, model catalogs and runner images can change.

## 1. Mission and scope

Maintain a VoiceInk fork that supports **native ChatGPT sign-in for audio transcription and optional LLM text enhancement**, without requiring an API key or installed CLI for that provider. Preserve the original VoiceInk features and allow both applications to coexist.

The user authorized the upstream update and checked DMG/ZIP publication on 2026-11-12. Review branch `codex/upstream-2.27-build230` targets stable upstream 2.27 as ChatGPT Build 230. Publication is conditional on independent review, native CI and package verification; do not treat a prepared merge as a released binary.

### Entry points

- Maintained fork: https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork
- Original upstream: https://github.com/Beingpax/VoiceInk
- Legacy repository/history: https://github.com/megaschatzi/VoiceInk-ChatGPT
- Releases: https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/releases
- Upstream feature proposal: https://github.com/Beingpax/VoiceInk/issues/1063

Start with `AGENTS.md`, `PROJECT_STATUS.md`, this file, `CHATGPT-INTEGRATION.md`, `UPSTREAM.json` and `CHATGPT-BUILD.md`. `PROJECT_STATUS.md` is the durable current-state record; release tags and manifests identify the exact binary source. `main` can contain later documentation. Do not depend on the previous conversation or an old workspace.

## 2. Verified baseline and next candidate

| Item | Verified value |
| --- | --- |
| Latest fork release | VoiceInk **2.26 — ChatGPT Build 229** |
| Release tag | `v2.26-chatgpt-build229` |
| Exact binary source | `750fdeb5b312a54dce412ecf4600631d92e75abd` |
| Integrated upstream | `4bc74caddfad6fdfab71e5957451b83b33c1a2c5` |
| Upstream marketing/build | 2.26 / 226 |
| Minimum macOS | 15.0 |
| Supported release architecture | Apple Silicon / arm64 |
| Next unused ChatGPT build at verification | **230**, subject to a fresh release check |
| Review validation | https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/actions/runs/42360324482 |
| Final build/publication | https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/actions/runs/42361416234 |

Build 229 passed 31 protocol tests, mode migration/backup checks, native-client typechecking, full app compilation, signature checks, extracted ZIP checks and mounted DMG checks. Public downloads were retrieved without login; checksums, source manifest, app identity, version/build, minimum macOS and arm64 executable matched. These are historical results for 229, not validation of a future update. No real ChatGPT account/audio was used in CI.

**Upstream 2.27 is available**, published 2026-11-11. Tag `v2.27` resolves to `b5d1be9a7c7377dd059f37bb3e0f791b802d4001` at verification. Its release notes list ElevenLabs Scribe V3 support, keeping the display awake during dictation, and performance improvements. It is integrated in the current update as **VoiceInk 2.27 — ChatGPT Build 230**. Independent code review and native review validation passed ([run 43167075878](https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork/actions/runs/43167075878)). The final main-branch build/publication and public download checks remain pending until recorded in `PROJECT_STATUS.md`. Inspect newer upstream releases before future updates.

### Specific 2.27 review hotspots

The upstream diff from our recorded base includes the Xcode project, app/engine observation, dashboard performance, recorder sleep prevention, API-key presence caching, KeychainService, ElevenLabs batch/streaming providers and the upstream appcast.

- `KeychainService.exists(forKey:syncable:)` changes from `Bool` to `Bool?`, distinguishing inaccessible/locked Keychain from a missing item. Audit every caller and keep our non-syncing ChatGPT credential storage, generation guards, refresh/sign-out and local-build fallback intact. Do not cache a transient Keychain failure as a missing account.
- Review APIKeyManager's new presence cache and invalidation; native ChatGPT account state must not be mistaken for an API key.
- Preserve our app construction and separate storage while merging app/engine observation changes. Verify recording state, enhancement, sleep prevention and history behavior after integration.
- Verify the new ElevenLabs provider/model behavior without changing the ChatGPT audio path or assuming equal model capabilities.
- Resolve version/build and bundle-identity conflicts deliberately. Never accept upstream app identity or update-feed settings wholesale.

## 3. Collaboration with sub-agents

Use sub-agents for useful independent work when available; the main agent owns coordination, evidence, integration and the final result.

- Assign separate scopes, for example upstream impact review, merge implementation, and independent release/package review. Avoid multiple agents editing the same files or Git branch simultaneously.
- Choose an available model and effort suited to the task. User preference: Luna/Medium for simple checks; Terra/Medium for substantive code; higher effort selectively for difficult debugging. These are preferences, not a guarantee those exact agent models exist in every environment.
- Give each agent the objective, allowed files/actions, repository instructions and expected deliverable. All agents follow the same privacy, identity, attribution and verification constraints.
- Prefer read-only independent review of important merges and release changes. The main agent verifies findings; a sub-agent's success claim is not release evidence.
- If sub-agents/model choices are unavailable, continue with available capabilities and disclose the limitation. Do not block routine work just to delegate.

## 4. App identity and user settings

Preserve `VoiceInk ChatGPT.app` and bundle ID **`com.megaschatzi.VoiceInk.ChatGPT`** (plus the existing development identity). Keep `AppIdentity.swift`, the preferences suite, database/history/recordings paths, Keychain service and credential identifiers compatible with previous ChatGPT builds. Do not rename these for branding or upstream merges.

The original VoiceInk updater is disabled for this fork. Never point it at the original app's update feed or let it replace the fork. The user-facing project title is **VoiceInk ChatGPT | by Spezi**.

- Updating this fork: quit it and replace the existing app in Applications; existing settings/data remain.
- First migration from original VoiceInk: export **Settings → Backup**, then import in VoiceInk ChatGPT; select all or desired categories.
- Modes, custom prompts, dictionary words/replacements, shortcuts, general settings and custom model definitions can transfer through settings backup.
- History/recordings are not migrated by that export. Sign-ins, API keys and macOS permissions must be configured again. Original app data stays separate.
- Run one dictation app at a time to avoid shortcut conflicts. Shared model caches may still be managed by dependency libraries.
- A dictionary JSON and a full settings backup are different import formats. Do not invent one schema from the other; inspect a genuine export before conversion and preserve existing entries/IDs.

## 5. ChatGPT request flow and limitations

1. Native browser device-code OAuth sign-in through OpenAI.
2. Audio upload to `https://chatgpt.com/backend-api/transcribe` for transcription.
3. Optional transcript/prompt/context sent to `https://chatgpt.com/backend-api/codex/responses` for LLM editing.

These are experimental internal endpoints, not a documented public subscription API. The user reported successful Plus and Pro ($100/month) tests; that does not establish universal entitlement, billing treatment, fixed quotas or permanent availability. Never describe the feature as unlimited or promise included audio minutes.

Audio and text go to OpenAI. Clipboard, selected text and window context may also be sent when enabled. OAuth credentials stay in the app's separate non-syncing macOS Keychain item. Preserve refresh-token rotation, sign-out, generation/cancellation protection and one retry after 401. Do not turn 403/429 into account switching or fallback API charges. Do not expose credentials or user content in diagnostics.

### Audio model versus text model

The current dictation request sends audio and an optional language, **no model ID**. The internal backend chooses the speech model. Our successful audio test did not establish its underlying model.

Luna/Sol/Terra and reasoning choices control text enhancement only. Finding `gpt-4o-mini-transcribe` in a Codex Realtime code path does not prove that this different dictation endpoint uses it. Public OpenAI API model availability/prices also do not establish subscription endpoint behavior. Likewise, no controlled comparison of this endpoint against ElevenLabs Scribe v2 was completed.

### Text model and reasoning controls

At this baseline the catalog includes GPT-6 Luna, GPT-6.1 Terra, GPT-6.1 Sol, GPT-6 Sol and GPT-6 Astra, plus earlier GPT-5.6 presets and custom IDs. Inspect the actual catalog/server support rather than assuming the names remain current or available to every account.

Existing modes keep **Low**. Known presets expose supported levels; incompatible selections reset according to current catalog logic. Custom IDs expose Low/Medium/High subject to server support. Medium/higher requests have at least a 120-second timeout. Preserve unknown/custom values through persistence/import where appropriate. Higher reasoning does not guarantee better transcription or editing. Treat `none` as model-specific; do not expose unsupported levels universally. Language/model guidance is advice, not a measured quality ranking.

CLI enhancement remains an optional separate path. Its command controls its own model/effort; omitting `-m` uses effective Codex configuration, not a promised hard-coded model. Example template:

```sh
codex exec -m "<supported-model-id>" -c model_reasoning_effort=low --skip-git-repo-check --ephemeral "$VOICEINK_FULL_PROMPT"
```

Do not require that CLI for native ChatGPT audio or text enhancement. There is no implemented complete per-app ChatGPT usage ledger; Codex CLI session statistics do not automatically account for native VoiceInk requests.

## 6. Important implementation and debugging knowledge

| Area | Source |
| --- | --- |
| Native account lifecycle, audio/text requests | `VoiceInk/Infrastructure/Providers/ChatGPT/ChatGPTClient.swift` |
| Protocol, multipart, model catalog, reasoning, SSE | `VoiceInk/Infrastructure/Providers/ChatGPT/ChatGPTProtocol.swift` |
| Transcription integration | `VoiceInk/Infrastructure/Providers/Transcription/Cloud/ChatGPTProvider.swift` |
| Credentials | `VoiceInk/Infrastructure/Credentials/KeychainService.swift` |
| Separate app identity | `VoiceInk/App/Configuration/AppIdentity.swift` |
| Connection UI | `VoiceInk/Features/ModelLibrary/Views/ChatGPT/ChatGPTConnectionView.swift` |
| Per-mode persistence/UI | `VoiceInk/Features/Modes/State/ModeConfig.swift`, `ModeConfigDraft.swift`, `Views/ModeConfigFormView.swift` |
| Enhancement routing | `VoiceInk/Features/Enhancement/Workflows/AIEnhancementService.swift` |
| Focused tests | `Tests/ChatGPTCoreTests`, `scripts/test-chatgpt-mode-settings.py` |
| CI/release | `.github/workflows/chatgpt-macos.yml`, `scripts/package-chatgpt-macos.sh`, `scripts/publish-chatgpt-release.sh`, `scripts/release-manifest.py` |

The original LLM failure occurred despite successful audio transcription and working CLI enhancement. A user-run diagnostic confirmed HTTP 200 with SSE events but **no Content-Type header**. Keep tolerant SSE framing/line-ending handling, JSON event validation, terminal completion checks and EOF handling; do not treat a successful response as one JSON object or reject it solely for a missing MIME header. Reject genuinely incomplete responses and return useful errors.

A historical Python test initially failed certificate validation; supplying a trusted certifi CA bundle resolved that local TLS problem. This is not a reason to disable TLS verification in the app. DNS failures in a separate execution environment do not establish a failure on the user's Mac.

## 7. Upstream update and release procedure

### Inspect and prepare

```sh
git clone https://github.com/megaschatzi/VoiceInk-ChatGPT-Fork.git VoiceInk
cd VoiceInk
git remote add upstream https://github.com/Beingpax/VoiceInk.git
git fetch origin --tags
git fetch upstream --tags
git config user.name 'Spezi (Codex)'
git config user.email 'spezi@voiceink-chatgpt.invalid'
git switch -c update/upstream-next
```

For an existing checkout, inspect status/remotes first and avoid overwriting local work. Read the live upstream release notes, compare against `UPSTREAM.json` and select an exact upstream commit/tag. Never use a forced fork sync. Merge on the review branch, inspect conflicts and verify our ChatGPT changes are still present. Update `UPSTREAM.json` with the original repository/branch/commit/version/build.

Update both Xcode configurations' marketing version and the monotonically increasing **ChatGPT** build number. Keep upstream build metadata separate; do not reset to build 3 or copy the upstream build counter. Update the changelog, release notes, relevant build guidance and durable status accurately, without claiming an unverified release is complete.

### Validate on a native Mac

The verified CI configuration is **standard Apple Silicon `macos-26`, Xcode 26.6, Swift 6.3+**. The updated MLX dependencies previously failed with Swift 6.2 on a macOS 15 fallback. Do not reintroduce that fallback or Intel packaging. Check that the selected Xcode image still exists; a queue/capacity issue is not evidence the source needs changing.

On a suitable local Mac the baseline commands are:

```sh
swift test
python3 scripts/test-chatgpt-mode-settings.py
bash scripts/test-api-key-cache.sh
swiftc -typecheck -swift-version 5 \
  VoiceInk/Infrastructure/Providers/ChatGPT/ChatGPTProtocol.swift \
  VoiceInk/Infrastructure/Providers/ChatGPT/ChatGPTClient.swift \
  VoiceInk/Infrastructure/Credentials/KeychainService.swift
bash scripts/build-whisper-macos.sh
make local LOCAL_CODESIGN_IDENTITY=-
bash scripts/package-chatgpt-macos.sh "$HOME/Downloads/VoiceInk ChatGPT.app" dist
```

Do not claim these macOS checks passed on a Linux workspace without Swift/Xcode. CI provides the native validation. The workflow tests protocol/lifecycle behavior, mode defaults/migration/backup round trips, client typechecking, the full app, signatures and actual packages. Add targeted tests when new behavior warrants them; avoid redundant tests that simply restate implementation.

Push a review branch and manually dispatch its workflow with **`publish_release=false`**. Arbitrary review branch pushes do not automatically run the workflow; the push trigger names only `main` and `feature/chatgpt-native`. For example:

```sh
git push -u origin HEAD
gh workflow run chatgpt-macos.yml --repo megaschatzi/VoiceInk-ChatGPT-Fork \
  --ref update/upstream-next -f publish_release=false
```

Wait for success and resolve actual failures. Independently review important merge, identity, credentials and packaging changes. Preserve the `LOCAL_BUILD` credential fallback behavior and do not seed CI with real account credentials or personal recordings. User testing of sign-in, dictation and enhancement on a Mac remains a separate runtime confirmation.

### Publish after validation

Integrate the verified change into `main` without force-pushing. The existing workflow publishes only from `main`: either manually dispatch with **`publish_release=true`**, or use **`[release]`** in the main head commit. Avoid starting duplicate concurrent publishing runs; use the existing supported publication path.

A regular successful push can already start a build. Plan the final release trigger before pushing rather than starting a second manual run accidentally. After publication, update durable evidence separately if needed; documentation-only updates should not rebuild the app.

Required release assets:

- Versioned DMG containing the app, Applications shortcut and license.
- Versioned ZIP containing `VoiceInk ChatGPT.app`.
- `SHA256SUMS`.
- `release-manifest.json` with exact source, upstream provenance and package hashes.

Naming example for the candidate above: `VoiceInk-2.27-ChatGPT-Build-230.dmg` / `.zip`, tag `v2.27-chatgpt-build230`, title **VoiceInk 2.27 — ChatGPT Build 230**. Refresh numbers from live state before using them. Keep completed releases regular **Latest** releases, not drafts/prereleases. Never replace an existing release's tag or binaries with a different build.

The fork publisher/package scripts are distinct from upstream `scripts/release.sh`; that upstream script targets the original app's distribution/signing assumptions. Do not substitute it for the fork pipeline.

### Verify public delivery

Retrieve every published asset without GitHub authentication. Verify SHA-256 hashes, manifest source/version/build/upstream, ZIP app identity/minimum macOS/version/architecture, and that the release tag resolves to the exact source. CI must check the extracted ZIP and mounted DMG plus signatures. Signing is currently **ad hoc, not Apple notarization**; document that honestly, and never instruct users to disable Gatekeeper.

Do not mark publication complete if tests, an upload, release visibility or public downloads remain unresolved. Preserve earlier release URLs, including legacy builds 226/227. Downloads and version-specific links belong in Releases rather than a manually maintained README download block.

## 8. Documentation, screenshots and source history

GitHub documentation and release notes are concise English; the user prefers a few useful emojis. Keep commits focused on lasting code/docs changes. Do not commit runner starts, queue states, retry logs or progress-only snapshots. Use author and committer **Spezi (Codex)** with `spezi@voiceink-chatgpt.invalid`, an intentionally unlinked address. Do not impersonate an upstream contributor or rewrite author history just for a display name/avatar.

Maintain `AGENTS.md`, `PROJECT_STATUS.md`, this handoff and the changelog with substantive changes. Historical evidence should remain dated, not silently presented as a new test. Documentation-only changes need link/diff checks, not full app builds; keep workflow documentation exclusions current.

Three genuine Build 228 screenshots remain beside their matching README features: sign-in, ChatGPT Dictation, and text model/reasoning selection. Current visual preference is **full app screenshots with simple orange frames only**: no arrows, zoom or overview/detail composites. No generative image editing. Explicitly label demo settings without a connected real account. Originals remain in commit `f39b7edf7eb4bd547fc8adcbf30c6e53a52f2f04`; reusable capture/annotation instructions are available through authorized project recovery material. Refresh actual captures if controls change rather than drawing invented UI.

The maintained repository is a true fork. The legacy independent repository now contains a redirect and license at main while earlier branches, history and releases remain. Do not delete it or break old links. A user-approved one-time history cleanup already occurred after a verified recovery snapshot; do not infer continuing permission for force-push/history rewriting.

## 9. Backups, privacy and upstream communication

An independent private source backup is maintained separately. It archives full source bundles, published assets, metadata and checksums daily and on manual dispatch. The public fork is authoritative. Authorized agents can consult private recovery instructions separately; do not expose private repository details in this public document or copy personal data into source snapshots. Manually maintained browsing refs are not continuously synchronized; completed dated archives are the primary recovery mechanism.

Do not commit business email prompts, vocabulary, customer examples, credentials, recordings or personal settings to the public fork. Such references are separate from application source; their availability must not be inferred from a source backup. Prompt experiments and compression drafts were not automatically deployed to the app. A private user export may describe those tasks separately.

Upstream issue **#1063** is open, with zero comments at the 2026-11-12 check. The user submitted it manually after an automated creation request lacked permission. The issue includes the fork/release links and three screenshots. Upstream `CONTRIBUTING.md` currently says external pull requests are not accepted; feature suggestions through issues are allowed. Re-check before contributing. Do not submit an unsolicited full-fork PR including branding/app identity/release infrastructure; if invited, prepare a focused change. Do not post comments or contact maintainers without user authorization. No automatic issue polling or unattended assistant monitoring is configured.

## 10. Completion checklist for the next app update

- [ ] Refresh releases, upstream tag/commit, issue feedback and repository instructions.
- [ ] Choose a non-overlapping agent plan where useful; assign independent review.
- [ ] Merge the chosen upstream release on a review branch and resolve credential/identity/UI conflicts deliberately.
- [ ] Preserve old settings, custom models, reasoning values, refresh/sign-out and original-app separation.
- [ ] Update exact upstream metadata, marketing version and next free ChatGPT build number.
- [ ] Pass relevant native tests/typecheck, full arm64 build and real ZIP/DMG validation.
- [ ] Obtain independent review; document live-account testing limitations.
- [ ] Integrate and publish complete regular Latest release through the existing workflow.
- [ ] Verify public downloads, hashes, source tag/manifest and app contents.
- [ ] Update durable status/changelog/instructions and the authorized source backup.
- [ ] Report actual results, release link, update instructions and remaining limitations.
