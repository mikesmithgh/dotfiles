#!/usr/bin/env bash
#
# find-scripts.sh: pick an executable script from $HOME/scripts with fzf.
#
# Prints the absolute path of the selected script to stdout. It does not run
# the script. The fish function `find_scripts` (bound to ctrl-s) calls this and
# inserts the result into the command line so arguments can be typed after it.
#
# Exit status: 0 on selection, 1 on cancel or no scripts found.

set -euo pipefail

scripts_dir="${SCRIPTS_DIR:-$HOME/scripts}"
self="$(basename "$0")"

if [[ ! -d "$scripts_dir" ]]; then
  printf 'find-scripts: directory not found: %s\n' "$scripts_dir" >&2
  exit 1
fi

# List executable regular files, relative to $scripts_dir, excluding this script.
list_scripts() {
  fd --type file --type executable --hidden --no-ignore --exclude .git --base-directory "$scripts_dir" . |
    grep -vxF "$self" | sort
}

selected="$(
  list_scripts | fzf --no-multi --prompt=' ' --border-label=' Scripts '
)" || exit 1

[[ -n "$selected" ]] || exit 1

printf '%s\n' "$scripts_dir/$selected"
