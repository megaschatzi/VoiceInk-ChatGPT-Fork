#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/voiceink-api-key-test.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT
swiftc -swift-version 5 -module-cache-path "$tmp_dir/cache" \
  VoiceInk/Infrastructure/Credentials/APIKeyManager.swift \
  Tests/APIKeyPresenceCacheTests.swift -o "$tmp_dir/test-api-key-cache"
"$tmp_dir/test-api-key-cache"
