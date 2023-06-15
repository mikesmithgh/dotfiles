#!/usr/bin/bash env

# hack to let us only get path, TODO: break this out
path_only='false'
if [[ "$1" == "path" ]]; then
  path_only='true'
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="/tmp/k9s.user/"
export XDG_STATE_HOME="$HOME/.local/state"


if [[ $OSTYPE == darwin* ]]; then
  # 15 is lowest setting on UI
  # 8 was too fast causing duplicate keystrokes
  # 10 i think this causes issues in bash cli when editing commands, not sure
  defaults write -g InitialKeyRepeat -int 12

  # 2 is lowest setting on UI
  defaults write -g KeyRepeat -int 2
fi

# custom maven config pulled from repo
# export M2_HOME="$HOME/repos/maven"
# maven_path="$M2_HOME/bin"

# required for local build of neovim
export VIMRUNTIME=~/gitrepos/neovim/runtime
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"

# homebrew setup
[[ -z ${HOMEBREW_PREFIX} ]] && eval "$(/opt/homebrew/bin/brew shellenv)" # Add homebrew to path if not set

declare -a my_prefix=(
  "${HOME}/bin"
  "${HOME}/go/bin"
  "${PYENV_ROOT}/bin"
  "${HOME}/gitrepos/neovim/build/bin"
  /Users/mike/.cargo/bin
  "$HOMEBREW_PREFIX/opt/libpq/bin"
)
declare -a my_suffix=(
  # ${macvim_bin_path}
)

function join_by {
  local IFS="$1"
  shift
  echo "$*"
}
export MYPATH_PREFIX=$(join_by ':' "${my_prefix[@]}")
export MYPATH_SUFFIX=$(join_by ':' "${my_suffix[@]}")

# export MYPATH="${HOME}/bin:${HOME}/go/bin:${maven_path}"
if [[ ${PATH} != *"${MYPATH_PREFIX}"*"${MYPATH_SUFFIX}"* ]]; then
  export PATH="${MYPATH_PREFIX}:${PATH}:${MYPATH_SUFFIX}"
fi

if [[ "$path_only" == 'true' ]]; then
  echo $PATH
  return
fi

# export JAVA_HOME="$(/usr/libexec/java_home -F -v 1.8)"
JAVA_HOME="$(/usr/libexec/java_home --verbose |& grep 'Amazon Corretto 20' | awk '{ print $9 }')"
export JAVA_HOME

GOPATH=$(go env GOPATH)
export GOPATH
# export GOPRIVATE=""
export GOARCH=arm64
export GOOS=darwin
# export CGO_ENABLED=1

# source files
declare -a source_files=(
  ".bash_colors"
  ".bash_functions"
  ".bash_myenv"
  # ".bash_ssh_add" # don't need this since it is now just a one liner
  "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" # home brew version of bash-completion, note this will source ~/.bash_completion
  ".swift-package-complete.bash"
)

# source files which require commands in above source files
declare -a dependent_source_files=(
  #   ".bash_repo_aliases"
)

# source user's files if they exist
for i in "${source_files[@]}"; do
  if [ -f "${HOME}/${i}" ]; then
    source "${HOME}/${i}"
  elif [ -f "${i}" ]; then
    source "${i}"
  fi
done


# source dependent source files if they exist
for i in "${dependent_source_files[@]}"; do
  if [ -f "${HOME}/${i}" ]; then
    source "${HOME}/${i}"
  elif [ -f "${i}" ]; then
    source "${i}"
  fi
done

# environment variables
# export DISPLAY=localhost:0.0 # required for copy paste in vim
# export TERM=xterm-256color
# export TERM=xterm-kitty

# export LESS='RSFX' # ignore case, raw control character (for color), chop long lines, quit if one screen, no init
# export LESS='IRSFX' # ignore case, raw control character (for color), chop long lines, quit if one screen, no init
# export LESSOPEN="|lesspipe.sh %s"
export LESS='iJXRK --line-num-width=4 --use-color --color=P0.7$ --prompt=?f  %f :  (stdin) .?m(%T %i of %m) .?lt %lt-%lb?L/%L. .󱨅 %bB?s/%s. ?e(END) :?pB%pB\%..%t   v=>pipe e=>edit  %E $'

export EDITOR='nvim'
export VISUAL='nvim'
MY_PROMPT_COMMAND='source ~/gitrepos/bgps/bgps' # execute every time before bash displays prompt
# MY_PROMPT_COMMAND='source ~/gitrepos/bgps/bgps; _set_title;' # execute every time before bash displays prompt
if [[ ${PROMPT_COMMAND} != *${MY_PROMPT_COMMAND} ]]; then
  if [[ -z $PROMPT_COMMAND ]]; then
    export PROMPT_COMMAND="$MY_PROMPT_COMMAND"
  else
    export PROMPT_COMMAND="$(echo $PROMPT_COMMAND'; '$MY_PROMPT_COMMAND | sed -E 's/;;/;/g')"
  fi
fi

# see https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
# export HISTCONTROL='ignoreboth' # history, ignore commands that start with spaces and duplicates
# export HISTCONTROL='erasedups' # history, ignore commands that start with spaces and duplicates
# Setting HISTSIZE to a value less than zero causes the history list to be unlimited (setting it 0 zero disables the history list).
export HISTSIZE=
# Setting HISTFILESIZE to a value less than zero causes the history file size to be unlimited (setting it to 0 causes the history file to be truncated to zero size).
export HISTFILESIZE=

shopt -s histappend # append history see https://superuser.com/questions/211966/how-do-i-keep-my-bash-history-across-sessions
shopt -s histreedit # reedit a history substitution line if it failed
# shopt -s histverify  # edit a recalled history line before executing
# After each command, append to the history file and reread it
# PROMPT_COMMAND="${PROMPT_COMMAND+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r;"
PROMPT_COMMAND="${PROMPT_COMMAND} && history -a && history -c && history -r"

# alias commands
alias ag='ag --path-to-ignore ~/.agignore'
alias k='kubectl'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'

alias nrc='cd $XDG_CONFIG_HOME/nvim/ && nvim'
alias vimrc='cd $XDG_CONFIG_HOME/nvim && nvim'
alias nvimrc='cd $XDG_CONFIG_HOME/nvim && nvim'

alias bobnvim='VIMRUNTIME= ~/.local/share/bob/nvim-bin/nvim'
alias bobvim='bobnvim'
alias vim='nvim'
alias vi='vim'
alias v='vim'
alias iv='vim'
alias i='vim'

oldvim() (
  export MYVIMRC="$XDG_CONFIG_HOME/vim/.vimrc"
  # shellcheck disable=SC2034
  export VIMINIT=":set runtimepath+=$XDG_CONFIG_HOME/vim/|:source $MYVIMRC"
  # clear vim runtime to avoid neovim conflict
  export VIMRUNTIME='' 
  eval "$(which vim)"
)

alias ovim='oldvim'
alias ovi='oldvim'

alias nd='nvim -d'
alias nvimdiff='nvim -d'
alias vimdiff='nvimdiff'

alias downloads='cd ~/Downloads'
alias volumes='cd /Volumes'

# if interactive shell, disable xon/xoff to avoid conflicting with C-s history search
[[ $- == *i* ]] && stty -ixon

# export DOCKER_HOST=tcp://localhost:2375

# unset variables
unset source_files
unset dependent_source_files

touch ~/.motd && cat ~/.motd | xargs -0 -n1 printf %b $(get_color txt hifo pur)

# AWS
# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html#envvars-list-aws_cli_auto_prompt
export AWS_CLI_AUTO_PROMPT='on-partial'
alias aws-prompt='aws --cli-auto-prompt'
# export AWS_SDK_LOAD_NONDEFAULT_CONFIG=1
alias localaws='aws --endpoint-url=http://localhost:4566'

# TODO review below, it was copied it

export VIRTUAL_ENV_DISABLE_PROMPT=1

alias notes="cd ~/Documents/notes"
alias secureg="cd ~/Documents/notes/secureg/"
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

# display settings
alias display-wide='displayplacer "id:57213D25-59E0-43E5-977D-86C571A2E6EB res:3440x1440 hz:60 color_depth:8 scaling:off origin:(0,0) degree:0" "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1728x1117 hz:120 color_depth:8 scaling:on origin:(-1728,323) degree:0" "id:42B02A68-B135-44F3-9F98-FFA811FDAA90 res:1920x1080 hz:60 color_depth:8 scaling:off origin:(3440,360) degree:0"'
alias display-standard='displayplacer "id:57213D25-59E0-43E5-977D-86C571A2E6EB res:1920x1080 hz:60 color_depth:8 scaling:off origin:(0,0) degree:0" "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1728x1117 hz:120 color_depth:8 scaling:on origin:(-1728,-37) degree:0" "id:42B02A68-B135-44F3-9F98-FFA811FDAA90 res:1920x1080 hz:60 color_depth:8 scaling:off origin:(1920,0) degree:0"'

diary() {
  cd /Users/mike/Documents/notes/wiki/diary || return
  vim -c 'NERDTree' -c 'wincmd l' -c 'normal 1 w wG' # space is <leader> cannot start with space so '1 ' represents first space
}

# my functions

lastnote() {
  cd "${HOME}/Documents/notes" || return
  latest_file="$(ls -rt | tail -1)"
  nvim -c 'NvimTreeOpen' -c 'wincmd l' "${latest_file}"
}

newnote() {
  if [[ -n $1 ]]; then
    if [[ -n $2 ]]; then
      fileext="${2}"
    else
      fileext="md"
    fi
    filename="$(date +%Y%m%d)-$1"
    cd "${HOME}/Documents/notes" || return
    nvim -c "NvimTreeOpen" -c "wincmd l" "${filename}.${fileext}"
  else
    echo "missing filename parameter"
  fi
}

makenote() {
  if [[ -n $1 ]]; then
    if [[ -n $2 ]]; then
      fileext=".${2}"
    else
      fileext=""
    fi
    filename="$(date +%Y%m%d)-$1"
    mv "${1}" "${HOME}/Documents/notes/${filename}.${fileext}"
    cd "${HOME}/Documents/notes" || return
    vim -c "NvimTreeOpen" -c "wincmd l" "${filename}${fileext}"
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

# if not arguments are provided navigate to the root of the git repository
g() {
  if [ $# -eq 0 ]; then
    cd $(git root)
  else
    git "$@"
  fi
}

# iterm2 shell intergration
if [ -f "${HOME}/.iterm2_shell_integration.bash" ] && [ "$TERM_PROGRAM" == 'iTerm.app' ]; then
  source "${HOME}/.iterm2_shell_integration.bash"
fi

# ssh
# check if any identities added to ssh agent, if not then add default identities
# ssh-add -l 1>/dev/null || ssh-add --apple-use-keychain 2>&1 | xargs echo "$(echo -e \\n$(get_color txt hifo pur))" # color formatting for fun
ssh-add -l 1>/dev/null || ssh-add --apple-use-keychain 2>&1 | xargs -0 -n1 printf %b "$(tput setaf 5)"

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# https://github.com/rcaloras/bash-preexec
# precmd() {
# echo "precmd $?"
# echo "precmd $@"
# precy=cho
# }
# preexec() {
# echo "preexec $?"
# echo "preexec $@"
# precy=blow
# }
# TODO move and clean up
# alias vim-intro="vim -c ':terminal ++curwin vim --clean' -c ':sleep 1' -c ':call feedkeys(\"\<C-W>N\")' -c ':%y' -c ':call feedkeys(\"i:q!\<CR>\")' -c ':bdelete!' -c ':silent normal pddggddr~' -c ':execute \"w \" . tempname()'"

# TODO look into this
# export GOOS=linux

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_CTRL_R_OPTS='--prompt=" " --border-label=" History "'

# export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --scroll-off=5 --height=100% --bind 'alt-a:toggle-all' --history ${HOME}/.local/state/fzf/history.txt --history-size=100000"
FZF_DEFAULT_OPTS='--preview-window=60%,border-thinblock --margin 1,4 --border=thinblock --multi --layout=reverse --scroll-off=7 --height=100% --bind "alt-a:toggle-all" --history /Users/mike/.local/state/fzf/history.txt --history-size=100000 --cycle --info=inline-right --ellipsis=… --separator=─ --scrollbar=▊ --pointer=󰅂 --no-separator --marker=﹢ --prompt="$ "'

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color='"$($HOME/gitrepos/gruvsquirrel.nvim/extra/fzf/gruvsquirrel.sh)"'"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --no-ignore' # TODO: revisit the defaults
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export BAT_THEME='gruvsquirrel'

alias cbat='bat --paging=never --style=plain --theme gruvbox-dark'

# generated with vivid https://github.com/sharkdp/vivid
LS_COLORS="$(vivid generate ~/gitrepos/gruvsquirrel.nvim/extra/vivid/gruvsquirrel.yml)"
export LS_COLORS
# enable color support of ls and also add handy aliases
# if [ -x /usr/bin/dircolors ]; then
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#     alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
# fi

# use coreutile gnu
alias ls='gls --color=auto -p'
alias ll='ls -lAhrtGp'
alias l='ls -lAhrtGp'
alias l='exa --long --sort=time --time=modified --time-style=long-iso --all'
alias grep='ggrep --color=auto'
alias fgrep='gfgrep --color=auto'
alias egrep='gegrep --color=auto'
alias od='god'
alias awk='gawk'
alias sed='gsed'

alias ..='cd ..'

# r() {
#     local cmd opts dir;
#     cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune     -o -type d -print 2> /dev/null | cut -b3-"}";
#     opts="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore --reverse ${FZF_DEFAULT_OPTS-} ${FZF_ALT_C_OPTS-} +m";
#     dir=$(eval "$cmd" | FZF_DEFAULT_OPTS="$opts" $(__fzfcmd))
#     cd -- $dir
# }

p() {
  if ((!$#)); then
    local directory
    directory="$(ms_ls_projects | fzf --ansi --prompt=' ' --border-label=' Projects ')"
    if [[ $directory != "" ]]; then
      ms_cd_project "$directory"
    fi
  else
    ms_cd_project "$@"
  fi
}

n() {
  if ((!$#)); then
    local path
    path="$(ms_nvim_dirs | fzf --ansi --prompt=' ' --border-label=' Neovim Directories ')"
    if [[ $path != "" ]]; then
      if [[ -d ${path} ]]; then
        cd "$path" || return
        # nvim -c "NvimTreeOpen" -c "FzfLua files"
      else
        cd "$(dirname "$path")" || return
        nvim "$path"
      fi
    fi
  fi
}

nvimdirs() {
  local directory="$(ms_nvim_dirs | fzf)"
  if [[ $directory != "" ]]; then
    cd "$directory"
  fi
}

export MANPAGER='nvim +Man!'

# see https://github.com/rcaloras/bash-preexec
source "${HOMEBREW_PREFIX}/etc/profile.d/bash-preexec.sh"
# [[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# ruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

eval "$(pyenv init -)"

# export SUDO_ASKPASS='/opt/homebrew/bin/ssh-askpass'

# export GITHUB_WORKSPACE='/Users/mike/gitrepos/pdubs'
