#!/usr/bin/env bash
set -euo pipefail
tag=${1:?release tag required}
version=${2:?version required}
build=${3:?build required}
commit=${4:?source commit required}
package="VoiceInk-${version}-ChatGPT-Build-${build}"
files=("$package.zip" "$package.dmg" SHA256SUMS release-manifest.json)
shasum -a 256 -c SHA256SUMS
state=$(mktemp)
trap 'rm -f "$state"' EXIT
if gh release view "$tag" --json isDraft,targetCommitish > "$state" 2>/dev/null; then
  python3 - "$state" "$commit" <<'PY'
import json, sys
state=json.load(open(sys.argv[1]))
if state['targetCommitish'] != sys.argv[2]:
    raise SystemExit('Release version already belongs to another commit; increment the build number.')
PY
  draft=$(python3 -c 'import json,sys;print(str(json.load(open(sys.argv[1]))["isDraft"]).lower())' "$state")
  if [[ "$draft" != true ]]; then
    # An already published release is immutable. Validate it rather than clobber.
    check=$(mktemp -d)
    trap 'rm -f "$state"; rm -rf "$check"' EXIT
    gh release download "$tag" --pattern SHA256SUMS --dir "$check"
    cmp SHA256SUMS "$check/SHA256SUMS"
    echo "Release already published with matching commit and checksums."
    exit 0
  fi
  gh release upload "$tag" "${files[@]}" --clobber
else
  gh release create "$tag" "${files[@]}" --target "$commit" --draft --prerelease \
    --title "VoiceInk $version — ChatGPT Build $build" --notes-file .github/chatgpt-release-notes.md
fi
# Publish only after every package and checksum has uploaded successfully.
gh release edit "$tag" --draft=false --prerelease \
  --title "VoiceInk $version — ChatGPT Build $build" --notes-file .github/chatgpt-release-notes.md
