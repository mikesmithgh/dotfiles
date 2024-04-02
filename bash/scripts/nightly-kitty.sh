#!/usr/bin/env bash
set -ex
cd "$GOPATH/src/github.com/kovidgoyal/kitty" || exit 1
git pull
./dev.sh deps
./dev.sh build
