#!/usr/bin/env bash
set -e
cd "$HOME/gitrepos/neovim" || exit 1
git fetch
printf '\nUpdates: \n'
git --no-pager log --oneline '...@{u}'
printf '\npress enter to continue to continue or ctrl-c to abort\n'
read -r
git merge
set -x
make distclean
make CMAKE_BUILD_TYPE=RelWithDebInfo
nvim -c ":helptags ALL" -c "quit"
