# Project guidance

Read `PROJECT_STATUS.md`, `AGENT_HANDOFF.md`, `CHATGPT-INTEGRATION.md` and `UPSTREAM.json` before making changes. Keep GitHub documentation concise and in English.

## Start here

This repository is the maintained fork; the conversation and previous agent workspace are not required to continue development.

1. Read `PROJECT_STATUS.md` for the released baseline and verified evidence, then `CHATGPT-INTEGRATION.md` and `UPSTREAM.json` for behavior and upstream provenance.
2. Read `CHATGPT-BUILD.md` for local/CI checks and release publication. `CHANGELOG.md` and GitHub Releases describe shipped changes; the latest source on `main` may include documentation newer than the release tag.
3. Check the working tree and current remote state before editing. Use a review branch, preserve app identity and existing settings, validate the change, then deliver a coherent update.
4. Maintain the status, relevant instructions and changelog with the implementation. Report what was actually verified and any remaining limitation; never depend on unpublished chat context or local-only scripts.

The detailed maintenance rules below apply to every agent, including sub-agents.

For new agent-authored commits, use author and committer name `Spezi (Codex)` with `spezi@voiceink-chatgpt.invalid` (an intentionally unlinked reserved-domain address). Preserve historical attribution; do not rewrite history merely to rename authors.

- Preserve the separate VoiceInk ChatGPT app identity, Keychain namespace and data directories. Never migrate or overwrite the original VoiceInk app's data implicitly.
- ChatGPT text enhancement and audio transcription are separate experimental integrations. Do not promise included usage, billing terms, fixed audio models or permanent availability.
- Keep custom model IDs, supported reasoning levels, mode persistence and settings import compatible. Preserve unknown/custom values where appropriate.
- Never commit credentials, personal dictionaries, business prompts, recordings or private repository details to this public fork.
- Merge upstream deliberately; inspect conflicts and behavior, then update `UPSTREAM.json`. Do not assume GitHub's Sync fork button validates our changes.
- Validate relevant protocol tests, mode migration/backup round trips, native client typechecking and the macOS app build after code changes. Release packaging must verify the extracted ZIP and mounted DMG, app identity, version and signatures.
- Documentation-only changes need focused diff/link checks, not a full app build. The macOS workflow ignores the known documentation paths. Use the standard Apple Silicon macOS 26 runner and a compatible Swift 6.3+ Xcode toolchain; do not add Intel packages without a new request.
- Continue the existing ChatGPT build sequence. Keep upstream marketing version separate from our build number. Never overwrite a published release with different binaries.
- Preserve legacy release links. Publish complete DMG, ZIP, checksums and provenance together through the release workflow.
- Mark completed app releases as regular **Latest** releases so they appear in the repository sidebar. Keep experimental integration and signing limitations documented; do not replace release assets when changing visibility/labels.
- Keep download assets and version-specific download links in GitHub Releases. The README should describe features and installation without a manually maintained download/version block.
- Keep the three setup screenshots beside their corresponding features: ChatGPT connection/sign-in button, transcription-model selection, and text-model/reasoning selection. Use real app captures; explicitly label offline demo settings and never include personal data or real credentials. Refresh screenshots when those controls change.
- Use full app screenshots with simple orange frames around the relevant controls. No zoomed details, side-by-side compositions or arrows. Add frames deterministically to genuine captures without generative image editing; preserve original dimensions, UI text and all pixels outside the frame outlines.

## Sub-agent collaboration

Use sub-agents for useful independent work where available. The main agent coordinates and verifies the final result. Assign non-overlapping file scopes, pass all repository instructions, and independently review important changes. Prefer an available Luna/Medium-class agent for simple checks and Terra/Medium-class for substantial code; use higher effort selectively for hard debugging. If those agents/models are unavailable, continue with available capabilities and report the limitation. Do not delegate routine work solely to create activity. See `AGENT_HANDOFF.md` for the full workflow.

## Maintain the handoff

Update `PROJECT_STATUS.md` at durable milestones in the same delivery as the related change: shipped behavior, verified evidence, outstanding work and the next action. Add user-facing changes to `CHANGELOG.md`. Record release provenance when relevant. Never label work complete before verification.

Keep commits focused on lasting changes. Bundle related code and documentation; do not create public progress-only commits for runner starts, queue states, retries or ongoing tests. Keep temporary operational details in Actions logs or local untracked notes. Update stable handoff information when completing a task, not at every intermediate step.

Prepare and validate related work on a feature/review branch before integrating a coherent change into `main`. Preserve upstream history. Rewrite existing public history only when explicitly requested by the user, after verifying a recoverable backup and checking release/reference consequences; use a lease to avoid overwriting concurrent changes.

Review the status at the start and end of an agent session. These are instructions for active agents, not a claim that an unattended assistant monitors GitHub. GitHub workflows provide only the automation explicitly configured in this repository.
