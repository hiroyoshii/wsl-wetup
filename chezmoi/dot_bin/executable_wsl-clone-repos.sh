#!/usr/bin/env bash
set -euo pipefail

: "${WSL_GITHUB_REPOS:?WSL_GITHUB_REPOS is not set}"

BASE_DIR="${WSL_REPO_BASE:-$HOME/source/repos}"
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"

for repo in $WSL_GITHUB_REPOS; do
  name=$(basename "$repo")
  if [ -d "$name/.git" ]; then
    echo "✔ $repo already exists → fetch"
    (cd "$name" && git fetch --all --prune)
  else
    echo "⬇ clone $repo"
    git clone "https://github.com/$repo.git"
  fi
done
