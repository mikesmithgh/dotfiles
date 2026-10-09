#!/bin/bash

# Move iOS Simulator screenshots from the Desktop to ~/Pictures/screenshots.
# Matches both the current naming ("Screenshot iPhone 17 Pro 10-09-2026 at 2.06.39 PM.png")
# and the older naming ("Simulator Screenshot - iPhone 17 Pro - 2026-06-22 at 14.17.57.png").

srcDir="${HOME}/Desktop"
destDir="${HOME}/Pictures/screenshots"

mkdir -p "${destDir}"

shopt -s nullglob

moved=0
skipped=0
failed=0

# globs are written inline (not stored in a variable) so the spaces in the names don't word split
for file in \
	"${srcDir}"/"Screenshot iPhone "*.png \
	"${srcDir}"/"Screenshot iPad "*.png \
	"${srcDir}"/"Simulator Screenshot - "*.png; do
	name=$(basename "${file}")
	if [[ -e "${destDir}/${name}" ]]; then
		echo "skip (exists): ${name}"
		skipped=$((skipped + 1))
		continue
	fi
	if mv -n "${file}" "${destDir}/"; then
		echo "moved: ${name}"
		moved=$((moved + 1))
	else
		failed=$((failed + 1))
	fi
done

echo "${moved} moved, ${skipped} skipped, ${failed} failed"
