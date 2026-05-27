#!/usr/bin/env bash

on_exit() {
  local rc=$?
  [ $rc -ne 0 ] && echo "error: exited with $rc" >&2
}
trap on_exit EXIT

~/scripts/is-dotfiles-repo.sh || exit 1

cd "$(git root)" || exit 1

config_dir="$XDG_CONFIG_HOME/claude"
mkdir -p "$config_dir"

files=(
  "settings.json"
  "statusline-command.sh"
)

for f in "${files[@]}"; do
  source="$PWD/.config/claude/$f"
  xdg_target="$config_dir/$f"
  # claude does not support XDG base dir, workaround by symlinking homedir claude files to XDG config
  claude_target="$HOME/.claude/$f"
  if [ ! -e "$source" ]; then
    echo "error: $source does not exist" >&2
    exit 1
  fi
  if [ -L "$xdg_target" ]; then
    rm -- "$xdg_target"
  elif [ -e "$xdg_target" ]; then
    echo "error: $xdg_target exists and is not a symlink" >&2
    exit 1
  fi
  if [ -L "$claude_target" ]; then
    rm -- "$claude_target"
  elif [ -e "$claude_target" ]; then
    echo "error: $claude_target exists and is not a symlink" >&2
    exit 1
  fi
  ln -sv "$source" "$xdg_target"
  ln -sv "$xdg_target" "$claude_target"
done
