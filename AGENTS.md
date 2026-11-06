# Project guidance

Read `PROJECT_STATUS.md`, `CHATGPT-INTEGRATION.md` and `UPSTREAM.json` before making changes. Keep GitHub documentation concise and in English.

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

## Maintain the handoff

Update `PROJECT_STATUS.md` at durable milestones in the same delivery as the related change: shipped behavior, verified evidence, outstanding work and the next action. Add user-facing changes to `CHANGELOG.md`. Record release provenance when relevant. Never label work complete before verification.

Keep commits focused on lasting changes. Bundle related code and documentation; do not create public progress-only commits for runner starts, queue states, retries or ongoing tests. Keep temporary operational details in Actions logs or local untracked notes. Update stable handoff information when completing a task, not at every intermediate step.

Prepare and validate related work on a feature/review branch before integrating a coherent change into `main`. Preserve upstream history. Rewrite existing public history only when explicitly requested by the user, after verifying a recoverable backup and checking release/reference consequences; use a lease to avoid overwriting concurrent changes.

Review the status at the start and end of an agent session. These are instructions for active agents, not a claim that an unattended assistant monitors GitHub. GitHub workflows provide only the automation explicitly configured in this repository.
