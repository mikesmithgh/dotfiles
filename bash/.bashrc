#!/bin/bash
# .bashrc configuration

# source files
declare -a sourceFiles=(
  ".bash_colors"
  ".bash_completion"
  ".bash_functions"
  ".bash_myenv"
)

# source user's files if they exist
for i in "${sourceFiles[@]}" ; do
  if [ -f "${HOME}/${i}" ] ; then
    source "${HOME}/${i}"
  fi
done

# environment variables
export HISTCONTROL='ignoreboth' # history, ignore commands that start with spaces and duplicates
export MYPATH="${HOME}/bin"
if [[ ${PATH} != ${MYPATH}* ]] ; then
  export PATH="${MYPATH}:${PATH}" # prepend my path to path
fi
export LESS='IRSFX' # ignore case, raw control character (for color), chop long lines, quit if one screen, no init
export EDITOR='vim'
export VISUAL='vim'
export PROMPT_COMMAND='_set_title;' # execute every time before bash displays prompt

# alias commands
alias g='git'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias slimbladeleft="xinput set-button-map 'Kensington Kensington Slimblade Trackball' 3 2 1 5 4 6 7 8 9 10 11 12"
alias slimbladeright="xinput set-button-map 'Kensington Kensington Slimblade Trackball' 1 2 3 4 5 6 7 8 9 10 11 12"
alias vi='vim'

# unset variables
unset sourceFiles
