#!/bin/bash

# get git branch info
_git_info() {
  local green="\033[2;92m"
  local purple="\033[2;95m"
  local red="\033[2;91m"
  local white="\033[2;97m"
  local yellow="\033[0;33m"

  local gitSymbol=""
  local gitColor="$white"

  local pendingChanges
  pendingChanges="$(git status --porcelain 2>/dev/null)"
  if (( $? )) ; then
    return 1
  fi
  pendingChanges="$(echo $pendingChanges | wc -w)"

  local commitCounts
  commitCounts=($(git rev-list --left-right --count ...@{u} 2>/dev/null))

  if (( $? )) ; then
    gitColor="$purple"
  else
    if (( ! $pendingChanges )) ; then
      gitColor="$green"
    fi

    if (( ${commitCounts[0]} )) ; then
      gitColor="$yellow"
      gitSymbol="↑[${commitCounts[0]}]"
    fi

    if (( ${commitCounts[1]} )) ; then
      gitColor="$yellow"
      gitSymbol="↓[${commitCounts[1]}]"
    fi

    if (( ${commitCounts[0]} && ${commitCounts[1]} )) ; then
      gitSymbol="↕ ↑[${commitCounts[0]}] ↓[${commitCounts[1]}]"
    fi
  fi

  if (( $pendingChanges )) ; then
    gitColor="$red"
    gitSymbol="*$gitSymbol"
  fi

  if $1 ; then
    echo "$gitColor(%s) $gitSymbol"
  else
    echo "(%s) $gitSymbol"
  fi
}

# set title bar text to current working directory
_set_title () {
  # current working directory
  local dir="$PWD"

  # substitute a leading path that's in $HOME for "~"
  if [[ "$HOME" == ${dir:0:${#HOME}} ]] ; then
    dir="~${dir:${#HOME}}"
  fi

  echo -ne "\033]0;$dir\007"
}

# get PS1 prompt configuration
_get_ps1() {
  if $1 ; then
    local dirColor="\033[0;36m"
    local psColor="\033[0;92m"
    local textColor="\033[0m"
    __git_ps1 "\n\[$dirColor\]{\w} " "\n\[$psColor\][\u@\h] \[$dirColor\]\\$ \[$textColor\]" "$(_git_info $1)"
  else  
    __git_ps1 "\n{\w} " "\n[\u@\h] \\$ " "$(_git_info $1)"
  fi
}
