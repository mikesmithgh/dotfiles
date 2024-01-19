#!/bin/bash
tmpfile="$(mktemp)"
cat /dev/stdin > "$tmpfile"
SBNVIM_INPUT_FILE="$tmpfile" nvim --clean -n -M -S /Users/mike/bin/setup.lua
