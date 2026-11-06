# ChatGPT integration

Use an existing ChatGPT subscription for **both audio-to-text transcription and optional text enhancement**, without an API key or an installed CLI. The user reports testing with Plus and Pro ($100/month).

## Request flow

1. Native browser device-code OAuth sign-in through OpenAI; credentials stay in a separate non-syncing macOS Keychain item.
2. Recorded audio → `chatgpt.com/backend-api/transcribe` → transcript.
3. Optional transcript + prompt/context → `chatgpt.com/backend-api/codex/responses` → edited text.

The dictation backend chooses the speech model. Text-model and reasoning choices do not change it. Access and limits are account-dependent; internal endpoints have no compatibility or included-audio billing guarantee.

## Models and reasoning

Choose a preset or custom ID per mode. Current presets: GPT-6 Luna, GPT-6.1 Terra, GPT-6.1 Sol, GPT-6 Sol and GPT-6 Astra. Earlier presets: GPT-5.6 Luna/Terra/Sol.

Existing modes keep **Low**. Known models offer only supported reasoning levels; an incompatible selection resets to Low after changing models. Custom IDs expose Low/Medium/High, subject to server support. Medium and higher requests allow at least 120 seconds. CLI commands retain their own settings.

Expandable model/language guidance is a starting point, not a measured language ranking. The transcription language selector does not request translation. Text editing follows the configured prompt.

## Privacy and separation

Audio and text are sent to OpenAI. Selected text, clipboard and window context may also be sent when enabled. The app has its own identifier, preferences, credentials, databases and recordings. It does not open the original app's history. FluidAudio manages its own model cache, which may be shared.

OAuth refresh, sign-out and 401 retry are supported; 403/429 errors do not trigger account switching or API billing fallback. SSE parsing handles missing MIME headers and EOF completion; incomplete responses are rejected. Diagnostics omit credentials and user content. A complete per-app usage ledger is not implemented.

## Code map

- [Native client](VoiceInk/Infrastructure/Providers/ChatGPT/ChatGPTClient.swift)
- [Protocol, model catalog and reasoning](VoiceInk/Infrastructure/Providers/ChatGPT/ChatGPTProtocol.swift)
- [Transcription provider](VoiceInk/Infrastructure/Providers/Transcription/Cloud/ChatGPTProvider.swift)
- [Connection UI](VoiceInk/Features/ModelLibrary/Views/ChatGPT/ChatGPTConnectionView.swift)
- [Tests](Tests/ChatGPTCoreTests) · [Build/release workflow](.github/workflows/chatgpt-macos.yml)

[Download/install](README.md) · [Build/update](CHATGPT-BUILD.md) · [Changelog](CHANGELOG.md)
