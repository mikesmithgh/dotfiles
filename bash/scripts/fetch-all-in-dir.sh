#!/usr/bin/env bash
for d in */ ; do
    cd "$d" || exit
    git fetch
    cd - || exit
done
