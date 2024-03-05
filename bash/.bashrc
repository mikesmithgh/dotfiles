#!/usr/bin/env bash

# colors
purple="\033[0;35m"


# xdg base directories (https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
XDG_RUNTIME_DIR=$(mktemp -u -t "${USER}")
export XDG_RUNTIME_DIR
(mkdir -p "$XDG_RUNTIME_DIR" &) # this directory is important for neovim vim.fn.serverstart (used by fzf-lua)

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIRS='/usr/local/share'
# the following have been commented out for performance, this doesn't need to run every time lets extract this into a script
# mkdir -p "$XDG_CONFIG_HOME"
# mkdir -p "$XDG_DATA_HOME"
# mkdir -p "$XDG_STATE_HOME"
# mkdir -p "$XDG_CACHE_HOME"
# mkdir -p "$XDG_DATA_DIRS"


# path
# declare -a my_prefix=(
# 	"$HOME/bin"
# 	"$HOMEBREW_PREFIX/bin"
# 	"$HOME/go/bin"
# 	"$PYENV_ROOT/bin"
#   "$XDG_CONFIG_HOME/pyenv/bin"
# 	"$HOME/gitrepos/neovim/build/bin"
# 	"$HOME/.cargo/bin"
# 	"$HOMEBREW_PREFIX/opt/libpq/bin"
#   "$HOME/Library/Application Support/Coursier/bin"
# )
# declare -a my_suffix=(
# 	# ${macvim_bin_path}
# )
# function join_by {
# 	local IFS="$1"
# 	shift
# 	echo "$*"
# }
# MYPATH_PREFIX=$(join_by ':' "${my_prefix[@]}")
# export MYPATH_PREFIX
# MYPATH_SUFFIX=$(join_by ':' "${my_suffix[@]}")
# export MYPATH_SUFFIX
# [[ -z "$DEFAULT_PATH" ]] && export DEFAULT_PATH="$PATH"
# export PATH="${MYPATH_PREFIX}:${DEFAULT_PATH}:${MYPATH_SUFFIX}"

# the following is the hardcoded results of the above commands to improve speed
export PATH='/Users/mike/bin:/opt/homebrew/bin:/Users/mike/go/bin:/Users/mike/.config/pyenv/bin:/Users/mike/.config/pyenv/bin:/Users/mike/gitrepos/neovim/build/bin:/Users/mike/.cargo/bin:/opt/homebrew/opt/libpq/bin:/Users/mike/Library/Application Support/Coursier/bin:/Users/mike/.config/pyenv/shims:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/usr/local/go/bin::/opt/homebrew/opt/fzf/bin'


# osx specific
# the following have been commented out for performance, this doesn't need to run every time lets extract this into a script
# if [[ $OSTYPE == darwin* ]]; then
# 	# 15 is lowest setting on UI
# 	# 8 was too fast causing duplicate keystrokes
# 	# 10 i think this causes issues in bash cli when editing commands, not sure
# 	defaults write -g InitialKeyRepeat -int 12
#
# 	# 2 is lowest setting on UI
# 	defaults write -g KeyRepeat -int 2
#
# 	# allow holding key instead of mac default holding key to choose alternate key
# 	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
#
# 	# holding ctrl+cmd and using the mouse drags the window
# 	defaults write -g NSWindowShouldDragOnGesture yes
#
# 	# rectangle configuration for centered window <command-m> see https://github.com/rxhanson/Rectangle/blob/master/TerminalCommands.md#add-an-extra-centering-command-with-custom-size
# 	defaults write com.knollsoft.Rectangle specified -dict-add keyCode -float 46 modifierFlags -float 1048840
# 	defaults write com.knollsoft.Rectangle specifiedWidth -float 2000
# 	defaults write com.knollsoft.Rectangle specifiedHeight -float 800
#
#
#   # osx and kitty specific
#   if [[ "$TERM" == 'xterm-kitty' ]]; then
#     # new instances of kitty will have the correct path
#     cat ~/.config/kitty/macos-launch-services-cmdline.template | xargs -I {} printf "{}" "--override env=PATH=\"$PATH\"" >~/.config/kitty/macos-launch-services-cmdline
#   fi
# fi


# neovim / vim
export VIMRUNTIME="$HOME/gitrepos/neovim/runtime"  # required for local build of neovim
alias vim='nvim'
alias vi='vim'
alias ovim='oldvim'
alias ovi='oldvim'
alias bram='oldvim'
alias nvimdiff='nvim -d'
alias vimdiff='nvimdiff'

# TODO move to a script
# alias vim-intro="vim -c ':terminal ++curwin vim --clean' -c ':sleep 1' -c ':call feedkeys(\"\<C-W>N\")' -c ':%y' -c ':call feedkeys(\"i:q!\<CR>\")' -c ':bdelete!' -c ':silent normal pddggddr~' -c ':execute \"w \" . tempname()'"


# homebrew
# [[ -z ${HOMEBREW_PREFIX} ]] && eval "$(/opt/homebrew/bin/brew shellenv)" # Add homebrew to path if not set
# the following are hardcoded results of the above command to improve speed
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";


# source files
source "$HOME/.bash_functions"


# go
# GOPATH=$(go env GOPATH)
export GOPATH="$HOME/go"
# export GOPRIVATE=""
export GOARCH='arm64'
export GOOS='darwin'
# export CGO_ENABLED=1
# TODO look into this
# export GOOS=linux


# python
alias python='python3'
alias pip='pip3'

# python :: virtualenv (https://github.com/pypa/virtualenv)
# disable updating PS1 prompt, this is currently added with bgps
export VIRTUAL_ENV_DISABLE_PROMPT=1

# python :: pyenv (https://github.com/pyenv/pyenv)
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"


# less
# removed J because it caused issues with bat alignment
export LESS='iXK --raw-control-chars --mouse --line-num-width=4 --use-color --color=P0.7$ --prompt=?f  %f :  (stdin) .?m(%T %i of %m) .?lt %lt-%lb?L/%L. .󱨅 %bB?s/%s. ?e(END) :?pB%pB\%..%t   v=>pipe e=>edit  %E $'

export EDITOR='nvim'
export VISUAL='nvim'

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
export PROMPT_COMMAND='history -a && history -c && history -r'


# kubectl
alias k='kubectl'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'

# bob (https://github.com/MordechaiHadad/bob)
alias bobnvim='VIMRUNTIME= ~/.local/share/bob/nvim-bin/nvim'
alias bnvim='bobnvim'
alias bvi='bobnvim'

# intellij
alias intellij='open -a "/Applications/IntelliJ IDEA.app"'

# vsc*de
alias code='open -a /Applications/Visual Studio Code.app'

alias downloads='cd ~/Downloads'
alias volumes='cd /Volumes'


# <C-s> 
# if interactive shell, disable xon/xoff to avoid conflicting with C-s history search
[[ $- == *i* ]] && stty -ixon


# motd
alias motd='cat ~/.motd'
touch "$HOME/.motd" 
xargs -0 -n1 printf %b "$purple" < "$HOME/.motd"


# aws-cli
# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html#envvars-list-aws_cli_auto_prompt
export AWS_CLI_AUTO_PROMPT='on-partial'
alias aws-prompt='aws --cli-auto-prompt'
# export AWS_SDK_LOAD_NONDEFAULT_CONFIG=1
alias localaws='aws --endpoint-url=http://localhost:4566'

# rm
alias rm='rm -i'

# directoy shorcuts
alias notes='cd $HOME/Documents/notes'
alias scripts='cd $HOME/scripts'
alias gitrepos='cd $HOME/gitrepos'
alias repos='cd $HOME/repos'
alias todo='vim -o $HOME/Documents/notes/wiki/Running-TODOs.md $HOME/Documents/notes/wiki/Archived-TODOs.md -c "wincmd j" -c "vsplit" -c "resize 25" -c "e /Users/mike/Documents/notes/wiki/Low-Priority-TODOs.md" -c "wincmd k"'
alias ft3='vim $HOME/Documents/notes/ft3/ft3.md'

# display settings
alias display-wide='displayplacer "id:BFB91403-4291-4F36-A876-7573049BD36A res:3440x1440 hz:50 color_depth:8 enabled:true scaling:off origin:(0,0) degree:0" "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1728x1117 hz:120 color_depth:8 enabled:true scaling:on origin:(-1728,323) degree:0" "id:20D97340-3FA4-4BAF-A245-C27FBDECA1E2 res:1920x1080 hz:60 color_depth:8 enabled:true scaling:off origin:(3440,360) degree:0"'
alias display-standard='displayplacer "id:BFB91403-4291-4F36-A876-7573049BD36A res:2560x1440 hz:60 color_depth:8 enabled:true scaling:off origin:(0,0) degree:0" "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1728x1117 hz:120 color_depth:8 enabled:true scaling:on origin:(-1728,323) degree:0" "id:20D97340-3FA4-4BAF-A245-C27FBDECA1E2 res:1920x1080 hz:60 color_depth:8 enabled:true scaling:off origin:(2560,360) degree:0"'


# # iterm2 
# no longer using iterm2, comment for now and eventually delete
# if [ "$TERM_PROGRAM" == 'iTerm.app' ] && [ -f "${HOME}/.iterm2_shell_integration.bash" ]; then
# 	source "${HOME}/.iterm2_shell_integration.bash"
# fi


# localization
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'


export FZF_CTRL_R_OPTS='--prompt=" " --border-label=" History "'

# only needed one time, uncomment on new install
# mkdir -p '/Users/mike/.local/state/fzf/'
FZF_DEFAULT_OPTS=
if [[ "$TERM" == 'xterm-kitty' ]]; then
  FZF_DEFAULT_OPTS='--border=thinblock --scrollbar=▊'
fi
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"' --preview-window=60%,border-thinblock --margin 1,4 --multi --layout=reverse --scroll-off=7 --height=100% --bind "alt-a:toggle-all" --history /Users/mike/.local/state/fzf/history.txt --history-size=100000 --cycle --info=inline-right --ellipsis=… --separator=─ --pointer=󰅂 --no-separator --marker=﹢ --prompt="$ "'
# generate colors with $HOME/gitrepos/gruvsquirrel.nvim/extra/fzf/gruvsquirrel.sh
gruvsquirrel_fzf_colors='spinner:#8faa80:bold,fg:#c7c7c7,pointer:#ff6961:bold,preview-label:#504945:bold,hl+:#dbbc5f:bold:reverse,label:#504945:reverse:bold,bg+:#32302f,fg+:#a0a0a0:bold,info:#8faa80,query:#c7c7c7:bold,preview-bg:#070707,separator:#504945,disabled:#968c81:regular,border:#504945,prompt:#83a598,bg:#1a1a1a,hl:#a9d5c4:bold:reverse,gutter:#1a1a1a,marker:#d3869b:bold,preview-fg:#c7c7c7,scrollbar:#504945,header:#968c81'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color='$gruvsquirrel_fzf_colors'"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --no-ignore' # TODO: revisit the defaults
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# generated with vivid https://github.com/sharkdp/vivid
# LS_COLORS="$(vivid generate ~/gitrepos/gruvsquirrel.nvim/extra/vivid/gruvsquirrel.yml)"
export LS_COLORS='*~=3;38;2;150;140;129:bd=1;38;2;219;188;95:ca=0;38;2;7;7;7;48;2;255;105;97:cd=3;38;2;222;165;132:di=0;38;2;131;165;152:do=1;38;2;177;98;134:ex=1;38;2;83;101;78:fi=0;38;2;199;199;199:ln=3;38;2;69;133;136:mh=1:mi=0;38;2;199;199;199;48;2;175;58;3:no=0;38;2;199;199;199:or=3;38;2;175;58;3:ow=1;38;2;83;101;78:pi=0;38;2;211;134;155:rs=0:sg=0;38;2;7;7;7;48;2;214;153;29:so=1;38;2;211;134;155:st=0;38;2;199;199;199;48;2;131;165;152:su=0;38;2;199;199;199;48;2;255;105;97:tw=3;38;2;199;199;199;48;2;131;165;152:*.a=1;38;2;83;101;78:*.c=0;38;2;143;170;128:*.d=0;38;2;143;170;128:*.h=0;38;2;143;170;128:*.m=0;38;2;143;170;128:*.o=3;38;2;150;140;129:*.p=0;38;2;143;170;128:*.r=0;38;2;143;170;128:*.t=0;38;2;143;170;128:*.z=0;38;2;214;153;29:*.7z=0;38;2;214;153;29:*.as=0;38;2;143;170;128:*.bc=3;38;2;150;140;129:*.bz=0;38;2;214;153;29:*.cc=0;38;2;143;170;128:*.cp=0;38;2;143;170;128:*.cr=0;38;2;143;170;128:*.cs=0;38;2;143;170;128:*.di=0;38;2;143;170;128:*.el=0;38;2;143;170;128:*.ex=0;38;2;143;170;128:*.fs=0;38;2;143;170;128:*.go=0;38;2;143;170;128:*.gv=0;38;2;143;170;128:*.gz=0;38;2;214;153;29:*.hh=0;38;2;143;170;128:*.hi=3;38;2;150;140;129:*.hs=0;38;2;143;170;128:*.jl=0;38;2;143;170;128:*.js=0;38;2;143;170;128:*.ko=1;38;2;83;101;78:*.kt=0;38;2;143;170;128:*.la=3;38;2;150;140;129:*.ll=0;38;2;143;170;128:*.lo=3;38;2;150;140;129:*.md=0;38;2;219;188;95:*.ml=0;38;2;143;170;128:*.mn=0;38;2;143;170;128:*.nb=0;38;2;143;170;128:*.pl=0;38;2;143;170;128:*.pm=0;38;2;143;170;128:*.pp=0;38;2;143;170;128:*.ps=1;38;2;69;133;136:*.py=0;38;2;143;170;128:*.rb=0;38;2;143;170;128:*.rm=1;38;2;146;187;223:*.rs=0;38;2;143;170;128:*.sh=0;38;2;143;170;128:*.so=1;38;2;83;101;78:*.td=0;38;2;143;170;128:*.ts=0;38;2;143;170;128:*.ui=0;38;2;222;165;132:*.vb=0;38;2;143;170;128:*.wv=0;38;2;157;186;212:*.xz=0;38;2;214;153;29:*.aif=0;38;2;157;186;212:*.ape=0;38;2;157;186;212:*.apk=0;38;2;214;153;29:*.arj=0;38;2;214;153;29:*.asa=0;38;2;143;170;128:*.aux=3;38;2;150;140;129:*.avi=1;38;2;146;187;223:*.awk=0;38;2;143;170;128:*.bag=0;38;2;214;153;29:*.bak=3;38;2;150;140;129:*.bat=1;38;2;83;101;78:*.bbl=3;38;2;150;140;129:*.bcf=3;38;2;150;140;129:*.bib=0;38;2;222;165;132:*.bin=1;38;2;255;105;97:*.blg=3;38;2;150;140;129:*.bmp=0;38;2;157;186;212:*.bsh=0;38;2;143;170;128:*.bst=0;38;2;222;165;132:*.bz2=0;38;2;214;153;29:*.c++=0;38;2;143;170;128:*.cfg=0;38;2;222;165;132:*.cgi=0;38;2;143;170;128:*.clj=0;38;2;143;170;128:*.com=1;38;2;83;101;78:*.cpp=0;38;2;143;170;128:*.css=0;38;2;143;170;128:*.csv=0;38;2;219;188;95:*.csx=0;38;2;143;170;128:*.cxx=0;38;2;143;170;128:*.deb=0;38;2;214;153;29:*.def=0;38;2;143;170;128:*.dll=1;38;2;83;101;78:*.dmg=1;38;2;255;105;97:*.doc=1;38;2;69;133;136:*.dot=0;38;2;143;170;128:*.dox=3;38;2;83;101;78:*.dpr=0;38;2;143;170;128:*.elc=0;38;2;143;170;128:*.elm=0;38;2;143;170;128:*.epp=0;38;2;143;170;128:*.eps=0;38;2;157;186;212:*.erl=0;38;2;143;170;128:*.exe=1;38;2;83;101;78:*.exs=0;38;2;143;170;128:*.fls=3;38;2;150;140;129:*.flv=1;38;2;146;187;223:*.fnt=0;38;2;157;186;212:*.fon=0;38;2;157;186;212:*.fsi=0;38;2;143;170;128:*.fsx=0;38;2;143;170;128:*.gif=0;38;2;157;186;212:*.git=3;38;2;150;140;129:*.gvy=0;38;2;143;170;128:*.h++=0;38;2;143;170;128:*.hpp=0;38;2;143;170;128:*.htc=0;38;2;143;170;128:*.htm=0;38;2;219;188;95:*.hxx=0;38;2;143;170;128:*.ico=0;38;2;157;186;212:*.ics=1;38;2;69;133;136:*.idx=3;38;2;150;140;129:*.ilg=3;38;2;150;140;129:*.img=1;38;2;255;105;97:*.inc=0;38;2;143;170;128:*.ind=3;38;2;150;140;129:*.ini=0;38;2;222;165;132:*.inl=0;38;2;143;170;128:*.ipp=0;38;2;143;170;128:*.iso=1;38;2;255;105;97:*.jar=0;38;2;214;153;29:*.jpg=0;38;2;157;186;212:*.kex=1;38;2;69;133;136:*.kts=0;38;2;143;170;128:*.log=3;38;2;150;140;129:*.ltx=0;38;2;143;170;128:*.lua=0;38;2;143;170;128:*.m3u=0;38;2;157;186;212:*.m4a=0;38;2;157;186;212:*.m4v=1;38;2;146;187;223:*.mid=0;38;2;157;186;212:*.mir=0;38;2;143;170;128:*.mkv=1;38;2;146;187;223:*.mli=0;38;2;143;170;128:*.mov=1;38;2;146;187;223:*.mp3=0;38;2;157;186;212:*.mp4=1;38;2;146;187;223:*.mpg=1;38;2;146;187;223:*.nix=0;38;2;222;165;132:*.odp=1;38;2;69;133;136:*.ods=1;38;2;69;133;136:*.odt=1;38;2;69;133;136:*.ogg=0;38;2;157;186;212:*.org=0;38;2;219;188;95:*.otf=0;38;2;157;186;212:*.out=3;38;2;150;140;129:*.pas=0;38;2;143;170;128:*.pbm=0;38;2;157;186;212:*.pdf=1;38;2;69;133;136:*.pgm=0;38;2;157;186;212:*.php=0;38;2;143;170;128:*.pid=3;38;2;150;140;129:*.pkg=0;38;2;214;153;29:*.png=0;38;2;157;186;212:*.pod=0;38;2;143;170;128:*.ppm=0;38;2;157;186;212:*.pps=1;38;2;69;133;136:*.ppt=1;38;2;69;133;136:*.pro=3;38;2;83;101;78:*.ps1=0;38;2;143;170;128:*.psd=0;38;2;157;186;212:*.pyc=3;38;2;150;140;129:*.pyd=3;38;2;150;140;129:*.pyo=3;38;2;150;140;129:*.rar=0;38;2;214;153;29:*.rpm=0;38;2;214;153;29:*.rst=0;38;2;219;188;95:*.rtf=1;38;2;69;133;136:*.sbt=0;38;2;143;170;128:*.sql=0;38;2;143;170;128:*.sty=3;38;2;150;140;129:*.svg=0;38;2;157;186;212:*.swf=1;38;2;146;187;223:*.swp=3;38;2;150;140;129:*.sxi=1;38;2;69;133;136:*.sxw=1;38;2;69;133;136:*.tar=0;38;2;214;153;29:*.tbz=0;38;2;214;153;29:*.tcl=0;38;2;143;170;128:*.tex=0;38;2;143;170;128:*.tgz=0;38;2;214;153;29:*.tif=0;38;2;157;186;212:*.tml=0;38;2;222;165;132:*.tmp=3;38;2;150;140;129:*.toc=3;38;2;150;140;129:*.tsx=0;38;2;143;170;128:*.ttf=0;38;2;157;186;212:*.txt=0;38;2;199;199;199:*.vcd=1;38;2;255;105;97:*.vim=0;38;2;143;170;128:*.vob=1;38;2;146;187;223:*.wav=0;38;2;157;186;212:*.wma=0;38;2;157;186;212:*.wmv=1;38;2;146;187;223:*.xcf=0;38;2;157;186;212:*.xlr=1;38;2;69;133;136:*.xls=1;38;2;69;133;136:*.xml=0;38;2;219;188;95:*.xmp=0;38;2;222;165;132:*.yml=0;38;2;222;165;132:*.zip=0;38;2;214;153;29:*.zsh=0;38;2;143;170;128:*.zst=0;38;2;214;153;29:*TODO=0;38;2;83;101;78:*hgrc=3;38;2;83;101;78:*.bash=0;38;2;143;170;128:*.conf=0;38;2;222;165;132:*.dart=0;38;2;143;170;128:*.diff=0;38;2;143;170;128:*.docx=1;38;2;69;133;136:*.epub=1;38;2;69;133;136:*.fish=0;38;2;143;170;128:*.flac=0;38;2;157;186;212:*.h264=1;38;2;146;187;223:*.hgrc=3;38;2;83;101;78:*.html=0;38;2;219;188;95:*.java=0;38;2;143;170;128:*.jpeg=0;38;2;157;186;212:*.json=0;38;2;222;165;132:*.less=0;38;2;143;170;128:*.lisp=0;38;2;143;170;128:*.lock=3;38;2;150;140;129:*.make=3;38;2;83;101;78:*.mpeg=1;38;2;146;187;223:*.opus=0;38;2;157;186;212:*.orig=3;38;2;150;140;129:*.pptx=1;38;2;69;133;136:*.psd1=0;38;2;143;170;128:*.psm1=0;38;2;143;170;128:*.purs=0;38;2;143;170;128:*.rlib=3;38;2;150;140;129:*.sass=0;38;2;143;170;128:*.scss=0;38;2;143;170;128:*.tbz2=0;38;2;214;153;29:*.tiff=0;38;2;157;186;212:*.toml=0;38;2;222;165;132:*.webm=1;38;2;146;187;223:*.webp=0;38;2;157;186;212:*.woff=0;38;2;157;186;212:*.xbps=0;38;2;214;153;29:*.xlsx=1;38;2;69;133;136:*.yaml=0;38;2;222;165;132:*.cabal=0;38;2;143;170;128:*.cache=3;38;2;150;140;129:*.class=3;38;2;150;140;129:*.cmake=3;38;2;83;101;78:*.dyn_o=3;38;2;150;140;129:*.ipynb=0;38;2;143;170;128:*.mdown=0;38;2;219;188;95:*.patch=0;38;2;143;170;128:*.scala=0;38;2;143;170;128:*.shtml=0;38;2;219;188;95:*.swift=0;38;2;143;170;128:*.toast=1;38;2;255;105;97:*.xhtml=0;38;2;219;188;95:*README=1;38;2;222;165;132:*passwd=0;38;2;222;165;132:*shadow=0;38;2;222;165;132:*.config=0;38;2;222;165;132:*.dyn_hi=3;38;2;150;140;129:*.flake8=3;38;2;83;101;78:*.gradle=0;38;2;143;170;128:*.groovy=0;38;2;143;170;128:*.ignore=3;38;2;83;101;78:*.matlab=0;38;2;143;170;128:*COPYING=3;38;2;160;160;160:*INSTALL=1;38;2;222;165;132:*LICENSE=3;38;2;160;160;160:*TODO.md=0;38;2;83;101;78:*.desktop=0;38;2;222;165;132:*.gemspec=3;38;2;83;101;78:*Doxyfile=3;38;2;83;101;78:*Makefile=3;38;2;83;101;78:*TODO.txt=0;38;2;83;101;78:*setup.py=3;38;2;83;101;78:*.DS_Store=3;38;2;150;140;129:*.cmake.in=3;38;2;83;101;78:*.fdignore=3;38;2;83;101;78:*.kdevelop=3;38;2;83;101;78:*.markdown=0;38;2;219;188;95:*.rgignore=3;38;2;83;101;78:*COPYRIGHT=3;38;2;160;160;160:*README.md=1;38;2;222;165;132:*configure=3;38;2;83;101;78:*.gitconfig=3;38;2;83;101;78:*.gitignore=3;38;2;83;101;78:*.localized=3;38;2;150;140;129:*.scons_opt=3;38;2;150;140;129:*CODEOWNERS=3;38;2;83;101;78:*Dockerfile=0;38;2;222;165;132:*INSTALL.md=1;38;2;222;165;132:*README.txt=1;38;2;222;165;132:*SConscript=3;38;2;83;101;78:*SConstruct=3;38;2;83;101;78:*.gitmodules=3;38;2;83;101;78:*.synctex.gz=3;38;2;150;140;129:*.travis.yml=0;38;2;69;133;136:*INSTALL.txt=1;38;2;222;165;132:*LICENSE-MIT=3;38;2;160;160;160:*MANIFEST.in=3;38;2;83;101;78:*Makefile.am=3;38;2;83;101;78:*Makefile.in=3;38;2;150;140;129:*.applescript=0;38;2;143;170;128:*.fdb_latexmk=3;38;2;150;140;129:*CONTRIBUTORS=1;38;2;222;165;132:*appveyor.yml=0;38;2;69;133;136:*configure.ac=3;38;2;83;101;78:*.clang-format=3;38;2;83;101;78:*.gitattributes=3;38;2;83;101;78:*.gitlab-ci.yml=0;38;2;69;133;136:*CMakeCache.txt=3;38;2;150;140;129:*CMakeLists.txt=3;38;2;83;101;78:*LICENSE-APACHE=3;38;2;160;160;160:*CONTRIBUTORS.md=1;38;2;222;165;132:*.sconsign.dblite=3;38;2;150;140;129:*CONTRIBUTORS.txt=1;38;2;222;165;132:*requirements.txt=3;38;2;83;101;78:*package-lock.json=3;38;2;150;140;129:*.CFUserTextEncoding=3;38;2;150;140;129'


# eza
export EZA_COLORS="uu=38;2;167;192;128:gu=38;2;167;192;128:uR=38;2;255;105;97:gR=38;2;255;105;97:un=90:gn=90"
alias l='eza --hyperlink --long --sort=time --time=modified --time-style=relative --all --git --color=auto --icons=auto --group-directories-first --dereference'


# gnu / coreutil
alias ls='gls'
alias grep='ggrep --color=auto'
alias fgrep='gfgrep --color=auto'
alias egrep='gegrep --color=auto'
alias od='god'
alias awk='gawk'
alias sed='gsed'


# bash-preexec (https://github.com/rcaloras/bash-preexec)
# needs to be at this line .bashrc or else the error __bp_install: invalid signal specification, TODO: investigate
bash_preexec="${HOMEBREW_PREFIX}/etc/profile.d/bash-preexec.sh"
[[ -f "$bash_preexec" ]] && source "$bash_preexec"
first_precmd="skip"
precmd() { 
  # my attempt at somewhat lazy loading completions
  if [[ "$first_precmd" == "run2" ]]; then
    
    # color utilities
  	source "$HOME/.bash_colors"
    
    # sdkman
    [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

    first_precmd=
  fi
  if [[ "$first_precmd" == "run1" ]]; then
    
    # ssh
    # check if any identities added to ssh agent, if not then add default identities
    # run in background in a subshell
    (ssh-add -l 1>/dev/null || ssh-add --apple-use-keychain 2>&1 | xargs -0 -n1 printf '\n%b' "$purple" &)

    # bash completion
	  source "$HOMEBREW_PREFIX/share/bash-completion/bash_completion" # home brew version of bash-completion, note this will source ~/.bash_completion

    # fzf
    # [ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"
    # the following have been extracted from .fzf.bash
    source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.bash" 2> /dev/null
    source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.bash"

    first_precmd="run2"
  fi
  if [[ "$first_precmd" == "skip" ]]; then
    first_precmd="run1"
  fi
}


# # node version manager (https://github.com/nvm-sh/nvm)
# not using nvm at the moment, leave commented for now
# export NVM_DIR="$HOME/.nvm"
# [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # load nvm
# [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # loads nvm bash_completion


# sdkman (https://sdkman.io/)
export SDKMAN_DIR='/opt/homebrew/opt/sdkman-cli/libexec'


# java
# managed by sdkman
export JAVA_HOME="$HOMEBREW_PREFIX/opt/sdkman-cli/libexec/candidates/java/current"


# man
export MANPAGER='nvim +Man!'


# liquibase (https://github.com/liquibase/liquibase)
LIQUIBASE_HOME="$HOMEBREW_PREFIX/opt/liquibase/libexec"
export LIQUIBASE_HOME


# ps1 
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
  PS1="\[\n\e[0;33m\w\n\e[0;32m\u@local \e[0;36m\$\e[0m \]"
else
  # starship (https://starship.rs/)
  # eval "$(starship init bash)"
  # the following are hardcoded results of the above command to improve speed
  source /dev/stdin <<<"$($HOMEBREW_PREFIX/bin/starship init bash --print-full-init)"
fi


# unset variables
unset source_files
unset dependent_source_files
