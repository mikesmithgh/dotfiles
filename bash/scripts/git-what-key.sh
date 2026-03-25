#!/usr/bin/env bash
# utility to determine what ssh public key is used for git operations
GIT_SSH_COMMAND="ssh -vvv" git fetch 2>&1 |
  awk '
BEGIN {
  gray = "\033[90m"
  green = "\033[32m"
  reset = "\033[0m"
}

function clean(line) {
  sub(/^.*(Offering public key: |Server accepts key: )/, "", line)

  if (match(line, /\.pub/)) {
    return substr(line, 1, RSTART + RLENGTH - 1)
  }

  sub(/ \([^)]*\)$/, "", line)
  return line
}

/Offering public key:/ {
  print gray "→ Trying:   " clean($0) reset
}

/Server accepts key:/ {
  print green "✓ Accepted: " clean($0) reset 
}'
