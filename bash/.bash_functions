#!/bin/bash

# get git branch info
_git_info() {
  local colorize=true # boolean condition to colorize prompt
  if [ ! -z ${1+x} ]; then
    colorize=$1
  fi

  if [ "$(type -t __git_ps1)" = "function" ] && [ -n "$(__git_ps1)" ] ; then
    local green=""
    local red=""
    local yellow=""
    local purple=""
    local white=""

    if $colorize && [ "$(type -t get_color)" = "function" ] ; then
      green="$(get_color drk fo grn)"
      red="$(get_color drk fo red)"
      yellow="$(get_color drk fo ylw)"
      purple="$(get_color drk fo pur)"
      white="$(get_color txt fo wht)"
    fi

    local gitSymbol=""
    local gitColor="$white"
    local pendingCommitCount="$(git status -s | wc -l)"
    local hasUpstream="$(git rev-parse @{u} 2>/dev/null | wc -l)"

    if (( ! $pendingCommitCount )) ; then
      gitColor="$green"
    fi

    if (( $hasUpstream )) ; then
      local aheadCommitCount="$(git rev-list @{u}.. 2>/dev/null | wc -l)"
      local behindCommitCount="$(git rev-list ..@{u} 2>/dev/null | wc -l)"

      if (( $aheadCommitCount )) ; then
        gitColor="$yellow"
        gitSymbol=" ↑[$aheadCommitCount]"
      fi

      if (( $behindCommitCount )) ; then
        gitColor="$yellow"
        gitSymbol=" ↓[$behindCommitCount]"
      fi

      if (( $aheadCommitCount && $behindCommitCount )) ; then
        gitSymbol=" ↕ ↑[$aheadCommitCount] ↓[$behindCommitCount]"
      fi

    else
      gitColor="$purple"
    fi

    if (( $pendingCommitCount )) ; then
      gitColor="$red"
      gitSymbol=" *$gitSymbol"
    fi

    echo "$gitColor$(__git_ps1)$gitSymbol"
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
  if [ "$(type -t __git_ps1)" = "function" ] && [ -n "$(__git_ps1)" ] ; then
    dir="${dir}$(_git_info false)"
  fi

  echo -ne "\033]0;$dir\007"
}

# get PS1 prompt configuration
_get_ps1() {
  local colorize=true # boolean condition to colorize prompt
  if [ ! -z ${1+x} ]; then
    colorize=$1
  fi

  local dirColor=""
  local psColor=""
  local textColor=""
  local gitInfo=""

  if $colorize && [ "$(type -t get_color)" = "function" ] ; then
    dirColor="$(get_color txt fo cyn)"
    psColor="$(get_color txt hifo grn)"
    textColor="$(get_color rst)"
  fi
  echo "\n\[$dirColor\]{\w}$(_git_info)\n\[$psColor\][\u@\h] \[$dirColor\]\\$ \[$textColor\]"
}