#!/usr/bin/env python3
"""Record immutable source provenance and package hashes for each build."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

folder, version, build = Path(sys.argv[1]), sys.argv[2], sys.argv[3]
root = Path(__file__).resolve().parent.parent
upstream = json.loads((root / 'UPSTREAM.json').read_text())
assert upstream['version'] == version, 'Update upstream metadata before packaging a new base version'
files = []
for extension in ('zip', 'dmg'):
    path = folder / f'VoiceInk-{version}-ChatGPT-Build-{build}.{extension}'
    files.append({'name': path.name, 'bytes': path.stat().st_size,
                  'sha256': hashlib.file_digest(path.open('rb'), 'sha256').hexdigest()})
manifest = {'app': 'VoiceInk ChatGPT', 'bundle_id': 'com.megaschatzi.VoiceInk.ChatGPT',
            'version': version, 'chatgpt_build': int(build), 'upstream': upstream,
            'source_commit': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root, text=True).strip(),
            'source_repository': os.environ.get('GITHUB_REPOSITORY', 'megaschatzi/VoiceInk-ChatGPT-Fork'),
            'packages': files, 'signing': 'ad-hoc; not Apple-notarized'}
(folder / 'release-manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
