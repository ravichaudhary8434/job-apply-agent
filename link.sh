#!/usr/bin/env bash
# Symlink every skill/agent in this repo into ~/.claude (which may itself symlink into claude-fe-agent).
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
for d in "$HERE"/skills/*/; do n=$(basename "$d"); ln -sfn "$d" "$HOME/.claude/skills/$n"; echo "skills/$n -> $d"; done
for f in "$HERE"/agents/*.md; do n=$(basename "$f"); ln -sfn "$f" "$HOME/.claude/agents/$n"; echo "agents/$n -> $f"; done
