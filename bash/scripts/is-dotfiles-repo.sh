#!/usr/bin/env bash

set -euo pipefail

# Check if current directory is inside a git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "not inside a git repo" >&2
  exit 1
fi

# Get the repo root directory name
repo_name="$(basename "$(git rev-parse --show-toplevel)")"

# Check if the repo is named "dotfiles"
if [[ "$repo_name" == "dotfiles" ]]; then
  exit 0
else
  echo "git repo: $repo_name, expected: dotfiles" >&2
  exit 1
fi
