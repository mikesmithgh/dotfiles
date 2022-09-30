#!/bin/bash
# .bashrc configuration

eval "$(/opt/homebrew/bin/brew shellenv)"  # Add homebrew to path
brew_prefix="$(brew --prefix)"
export MYPATH="${HOME}/bin:${HOME}/go/bin:$brew_prefix/opt/gnu-getopt/bin:/opt/homebrew/anaconda3/bin"
if [[ ${PATH} != ${MYPATH}* ]] ; then
  export PATH="$(echo $MYPATH':'$PATH | sed -E 's/::/:/g')" # prepend my path to path
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# source files
declare -a source_files=(
  ".bash_colors"
  ".bash_functions"
  ".bash_myenv"
  ".bash_ssh_add"
  "$brew_prefix/etc/profile.d/bash_completion.sh"  # home brew version of bash-completion, note this will source ~/.bash_completion
)

# source files which require commands in above source files
declare -a dependent_source_files=(
  ".bash_repo_aliases"
)

# source user's files if they exist
for i in "${source_files[@]}" ; do
  if [ -f "${HOME}/${i}" ] ; then
    source "${HOME}/${i}"
  elif [ -f "${i}" ] ; then  
    source "${i}"
  fi
done

make_repo_aliases

# source dependent source files if they exist
for i in "${dependent_source_files[@]}" ; do
  if [ -f "${HOME}/${i}" ] ; then
    source "${HOME}/${i}"
  elif [ -f "${i}" ] ; then  
    source "${i}"
  fi
done


PROMPT_COMMAND='source ~/gitrepos/bgps/bgps'

# environment variables
# export DISPLAY=localhost:0.0 # required for copy paste in vim
export TERM=xterm-256color

export LESS='RSFX' # ignore case, raw control character (for color), chop long lines, quit if one screen, no init
# export LESS='IRSFX' # ignore case, raw control character (for color), chop long lines, quit if one screen, no init
export EDITOR='vim'
export VISUAL='vim'
MY_PROMPT_COMMAND="_set_title;" # execute every time before bash displays prompt
if [[ ${PROMPT_COMMAND} != *${MY_PROMPT_COMMAND} ]]; then
  if [[ -z "$PROMPT_COMMAND" ]]; then
    export PROMPT_COMMAND="$MY_PROMPT_COMMAND"
  else
    export PROMPT_COMMAND="$(echo $PROMPT_COMMAND'; '$MY_PROMPT_COMMAND | sed -E 's/;;/;/g')"
  fi
fi

# see https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
export HISTCONTROL='ignoreboth' # history, ignore commands that start with spaces and duplicates
export HISTSIZE=100000                    # big big history
export HISTFILESIZE=100000                # big big history
shopt -s histappend  # append history see https://superuser.com/questions/211966/how-do-i-keep-my-bash-history-across-sessions
shopt -s histreedit  # reedit a history substitution line if it failed
shopt -s histverify  # edit a recalled history line before executing
# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r;"

# alias commands
alias ag='ag --path-to-ignore ~/.agignore'
alias g='git'
alias k='kubectl'
alias ls='ls -G'
# alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias vi='vim'
alias downloads='cd ~/Downloads'

# if interactive shell, disable xon/xoff to avoid conflicting with C-s history search
[[ $- == *i* ]] && stty -ixon

# export JAVA_HOME="/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64"
# export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
# export JAVA_HOME='/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/' # TODO: check if this is needed
export JAVA_HOME="$(/usr/libexec/java_home -v11)" # TODO check if this is needed
export GOPATH=$(go env GOPATH)


# export DOCKER_HOST=tcp://localhost:2375

# unset variables
unset source_files
unset dependent_source_files

touch ~/.motd && cat ~/.motd


# TODO review below, it was copied it

export VIRTUAL_ENV_DISABLE_PROMPT=1

#!/bin/bash
alias notes="cd ~/Documents/notes"
alias scripts="cd ~/scripts"
alias rm='rm -i'
alias motd='cat ~/.motd'
alias k9sh='k9s --headless'
alias gitrepos="cd ${HOME}/gitrepos"
alias repos="cd ${HOME}/repos"
alias python='python3'
alias pip='pip3'
alias strip-color='sed "s/\x1B\[[0-9;]\{1,\}[A-Za-z]//g"'
alias todo='vim -o /Users/mike/Documents/notes/wiki/Running-TODOs.md /Users/mike/Documents/notes/wiki/Archived-TODOs.md -c "wincmd j" -c "vsplit" -c "resize 25" -c "e /Users/mike/Documents/notes/wiki/Low-Priority-TODOs.md" -c "wincmd k"'

diary() {
  cd /Users/mike/Documents/notes/wiki/diary; vim -c 'NERDTree' -c 'wincmd l' -c 'normal ,w,wG'
}

# my functions

lastnote() {
  cd "${HOME}/Documents/notes"
  latest_file="$(ls -rt | tail -1)"
  vim -c 'NERDTree' -c 'wincmd l' "${latest_file}"
}

newnote() {
  if [[ -n "$1" ]] ; then
    if [[ -n "$2" ]] ; then
      fileext="${2}"
    else
      fileext="md"
    fi
    filename="$(date +%Y%m%d)-$1"
    cd "${HOME}/Documents/notes"
    vim -c "NERDTree" -c "wincmd l" "${filename}.${fileext}"
  else  
    echo "missing filename parameter"
  fi
}

makenote() {
  if [[ -n "$1" ]] ; then
    if [[ -n "$2" ]] ; then
      fileext=".${2}"
    else
      fileext=""
    fi
    filename="$(date +%Y%m%d)-$1"
    mv "${1}" "${HOME}/Documents/notes/${filename}.${fileext}"
    cd "${HOME}/Documents/notes"
    vim -c "NERDTree" -c "wincmd l" "${filename}${fileext}"
  else  
    echo "missing filename parameter"
  fi
}

k9s_screens_dir="$(/opt/homebrew/bin/k9s info | grep 'Screen Dumps' | grep --color=never -o "/.*" | xargs echo)"
alias k9sscreens="cd '$k9s_screens_dir'"

lastk9sscreen() {
  k9s_dir='/var/folders/y5/74_673kn67z59s6tynk7ggh9rmwj8r/T/k9s-screens-mike.smith'
  latest_dir="${k9s_dir}/$(ls -1rt ${k9s_dir} | tail -1)"      
  latest_screen="${latest_dir}/$(ls -1rt ${latest_dir} | tail -1)" 
  vi "${latest_screen}"
}


make_repo_aliases() {
  repos_dir="${HOME}/repos"
  bash_repo_aliases="${HOME}/.bash_repo_aliases"
  cd "${repos_dir}"
  dirs=($(ls -1 | xargs echo))
  if [ -f "$bash_repo_aliases" ]; then
    mv $bash_repo_aliases "$bash_repo_aliases.bkp"
  fi
  echo '#!/bin/bash' > $bash_repo_aliases
  echo '# Generated from make_repo_aliases function' >>  $bash_repo_aliases
  echo "alias repos=\"cd $repos_dir\"" >>  $bash_repo_aliases
  for d in "${dirs[@]}"; do
    echo "alias $d-repo=\"cd ${repos_dir}/$d\"" >>  $bash_repo_aliases
  done

  # additional aliases
  # echo "alias claws-repo=\"cd ${repos_dir}/airgap/claws\"" >>  $bash_repo_aliases

  cd - &>/dev/null
}


