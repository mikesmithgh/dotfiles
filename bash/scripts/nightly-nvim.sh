#!/usr/bin/env bash

set -e

pinned='e572c9c80a6ec6d4eb25410e8aab9b7b2d33d1c1'

cd "$HOME/gitrepos/neovim" || exit 1

if [[ "$1" == '--pinned' ]]; then
  git checkout "$pinned"
  ms_info "\nPinned at %s, press enter to continue to continue or ctrl-c to abort\n" "$pinned"
  read -r
else
  git fetch
  ms_info '\nUpdates: \n'
  git --no-pager log --oneline '...@{u}'
  ms_info '\npress enter to continue to continue or ctrl-c to abort\n'
  read -r
  git merge
  set -x
fi

make distclean
make CMAKE_BUILD_TYPE=RelWithDebInfo
nvim -c ":helptags ALL" -c "quit"
