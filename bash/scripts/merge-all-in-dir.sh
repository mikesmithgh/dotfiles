#!/usr/bin/env bash
for d in */; do
	cd "$d" || exit
	pwd
	git merge
	cd - || exit
done
