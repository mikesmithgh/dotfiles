#!/usr/bin/env bash
set -e
cd "$GOPATH/src/github.com/kovidgoyal/kitty" || exit 1
git fetch
printf '\nUpdates: \n'
git --no-pager log --oneline '...@{u}'
printf '\npress enter to continue to continue or ctrl-c to abort\n'
read -r
git merge
set -x
./dev.sh deps
./dev.sh build
