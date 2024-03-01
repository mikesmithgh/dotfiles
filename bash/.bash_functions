#!/bin/bash

_kube_ps1() {
  if [ -f ~/.kube/config ]; then  
    # Get current context
    local context=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //" | xargs)

    if [ -n "$context" ]; then
      printf -- "󱃾 %s" "${context}"
    fi
  fi
}

_py_ps1() {
  if [ -n "${VIRTUAL_ENV}" ]; then  
    # Get current venv
    local base_dir="$(basename ${VIRTUAL_ENV})"
    local parent_dir="$(basename $(dirname ${VIRTUAL_ENV}))"
    local env=$(printf "%s" "${parent_dir}/${base_dir}")
    printf -- "%s %s" '' "${env}"
  fi
}

_code_ps1() {
  # requires bash-preexec to be installed
  local code="${__bp_last_ret_value}"
  # logic referenced from https://github.com/gnachman/iTerm2/blob/26c9f2e0397d97a9c4d8cc56293528142be1cb83/sources/iTermTextDrawingHelper.m#L938
  if (( code == 0 )); then
    green=$(printf "\x1b[%s;2;%sm" '38' '143;170;128')
    printf "%s%s" "${green}" '󰅂'
  elif (( code >= 128 && code <= 128 + 32 )); then
    yellow=$(printf "\x1b[%s;2;%sm" '38' '219;188;95')
    printf -- "%s%s" "${yellow}" " ${code} 󰅂"
  else
    red=$(printf "\x1b[%s;2;%sm" '38' '255;105;97')
    printf -- "%s%s" "${red}" " ${code} 󰅂"
  fi
  printf -- "%b " '\033[0m'
}

_bgps_ps1() {
  _bgps_get_opts $@
  bold=$(printf -- "%b" "\033[1m")
  color_stop=$(printf "%b" "\x1b[0m\n")
  rgb="255;0;40"

  s3_fg_rgb="168;153;132"
  s3_bg_rgb="63;56;54"
  s3_bg_color_start=$(printf "\x1b[%s;2;%sm" "48" $s3_bg_rgb)
  s3_bg_color_start_invert=$(printf "\x1b[%s;2;%sm" "38" $s3_bg_rgb)
  s3_fg_color_start=$(printf "%s\x1b[%s;2;%sm" $bold "38" $s3_fg_rgb)

  s2_fg_rgb="168;153;132"
  s2_bg_rgb="80;73;69"
  s2_bg_color_start=$(printf "\x1b[%s;2;%sm" "48" $s2_bg_rgb)
  s2_bg_color_start_invert=$(printf "\x1b[%s;2;%sm" "38" $s2_bg_rgb)
  s2_fg_color_start_invert=$(printf "\x1b[%s;2;%sm" "48" $s3_bg_rgb)
  s2_fg_color_start=$(printf "%s\x1b[%s;2;%sm" $bold "38" $s2_fg_rgb)



  # HEY! I know this code is terrible
  
  s2=""
  s3=""

  # python
  pps1="$(_py_ps1)"

  # k8s
  kps1="$(_kube_ps1)"

  if [ "$pps1" != "" ]; then  
    s2_fg_rgb="219;188;127"
    s2_bg_rgb="80;73;69"
    s2_bg_color_start=$(printf "\x1b[%s;2;%sm" "48" $s2_bg_rgb)
    s2_bg_color_start_invert=$(printf "\x1b[%s;2;%sm" "38" $s2_bg_rgb)
    s2_fg_color_start_invert=$(printf "\x1b[%s;2;%sm" "48" $s3_bg_rgb)
    if [ "$kps1" == "" ]; then
      s2_fg_color_start_invert="$color_stop"
    fi
    s2_fg_color_start=$(printf "%s\x1b[%s;2;%sm" $bold "38" $s2_fg_rgb)
    s2=$(printf "%s%s%s%s%s%s%s%s" $color_stop $s2_bg_color_start $s2_fg_color_start " $pps1" $color_stop $s2_fg_color_start_invert $s2_bg_color_start_invert '')
  fi

  if [ "$kps1" != "" ]; then
    s3_bg_color_start=$(printf "\x1b[%s;2;%sm" "48" $s3_bg_rgb)
    s3_bg_color_start_invert=$(printf "\x1b[%s;2;%sm" "38" $s3_bg_rgb)
    s3_fg_color_start=$(printf "%s\x1b[%s;2;%sm" $bold "38" $s3_fg_rgb)
    if [ "$s2" == "" ]; then
      # s2_fg_rgb="127;158;219"
      s2_fg_rgb="157;186;212"
      s2_fg_color_start=$(printf "%s\x1b[%s;2;%sm" $bold "38" $s2_fg_rgb)
      s2_fg_color_start_invert="$color_stop"
      ks2=$(printf "%s%s%s%s%s%s%s%s" $color_stop $s2_bg_color_start $s2_fg_color_start " $kps1" $color_stop $s2_fg_color_start_invert $s2_bg_color_start_invert '')
      s2="$ks2"
    else
      s3_fg_rgb="127;158;219"
      s3_fg_color_start=$(printf "%s\x1b[%s;2;%sm" $bold "38" $s3_fg_rgb)
      s3=$(printf "%s%s%s%s%s%s%s" $color_stop $s3_bg_color_start $s3_fg_color_start " $kps1" $color_stop $s3_fg_color_start_invert $s3_bg_color_start_invert '')
    fi
  fi

  # s3=$(printf "%s%s%s%s%s%s%s" $color_stop $s3_bg_color_start $s3_fg_color_start $w $color_stop $s3_bg_color_start_invert $s3_fg_color_start_invert '')

  s1_fg_rgb="7;7;7"
  s1_bg_rgb="168;153;132"
  s1_bg_color_start=$(printf "\x1b[%s;2;%sm" "48" $s1_bg_rgb)
  s1_bg_color_start_invert=$(printf "\x1b[%s;2;%sm" "38" $s1_bg_rgb)
  s1_fg_color_start_invert=$(printf "\x1b[%s;2;%sm" "48" $s2_bg_rgb)
  if [ "$s2" == "" ]; then
    s1_fg_color_start_invert="$color_stop"
  fi
  s1_fg_color_start=$(printf "%s\x1b[%s;2;%sm" $bold "38" $s1_fg_rgb)


  # date
  # s1=$(printf "%s%s%s%s%s%s%s%s" $color_stop $s1_bg_color_start $s1_fg_color_start $D $color_stop $s1_bg_color_start_invert $s1_fg_color_start_invert '')
  # shell version
  # s2=$(printf "%s%s%s%s%s%s%s%s" $color_stop $s2_bg_color_start $s2_fg_color_start $V $s $color_stop $s2_bg_color_start_invert $s2_fg_color_start_invert '')
  # pwd
  # s3=$(printf "%s%s%s%s%s%s%s" $color_stop $s3_bg_color_start $s3_fg_color_start $w $color_stop $s3_bg_color_start_invert $s3_fg_color_start_invert '')

  # pwd
  s1=$(printf "%s%s%s%s%s%s%s%s" $color_stop $s1_bg_color_start $s1_fg_color_start " $w" $color_stop $s1_fg_color_start_invert $s1_bg_color_start_invert '')

  printf -- "\n%s%s%s" "$s1" "$s2" "$s3"
}

# PS1_FORMAT="\V\s \[\033[0;36m\]\w\[\033[0m\]\[\033[3;33m\]$(_py_ps1)\[\033[0m\]\[\033[5;94m\]$(_kube_ps1)\[\033[0m\]%BGPS_GIT_STATUS $(_code_ps1)\n$([[ $(type -t iterm2_prompt_mark) == 'function' ]] && echo \[$(iterm2_prompt_mark)\])$(((${EUID})) && echo '\[\033[0;92m\]' || echo '\[\033[0;91m\]')\u@\h \[\033[0;36m\]\$ "

_bgps_get_opts() {
  while getopts ":u:h:D:V:s:w:" o; do
    case "${o}" in
      u)
        u="${OPTARG}"
        ;;
      h)
        h="${OPTARG}"
        ;;
      D)
        D="${OPTARG}"
        ;;
      V)
        V="${OPTARG}"
        ;;
      s)
        s="${OPTARG}"
        ;;
      w)
        w=$(dirs +0)
        ;;
      *)
        ;;
    esac
  done
  shift $((OPTIND-1))
}

_make_repo_aliases() {
  repos_dir="${HOME}/repos"
  bash_repo_aliases="${HOME}/.bash_repo_aliases"
  if [ -d "${repos_dir}" ]; then
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

    cd - &>/dev/null
  fi
}

ms_ls_projects() {
  # repo directories
  # DOTFILES_REPO_PROJECT_DIRS=$(fd --max-depth 3 --type file --hidden --no-ignore --glob --prune --search-path "${HOME}/gitrepos/" 'HEAD' --exec realpath "{//}" | sed -e 's/\/\.git.*//')
  DOTFILES_REPO_PROJECT_DIRS=$(fd --color=never --exact-depth 1 --type directory --glob --search-path "${HOME}/repos" --search-path "${HOME}/gitrepos/" --exec realpath "{}")
  # go directories
  DOTFILES_GO_PROJECT_DIRS=$(fd --color=never --min-depth 2 --max-depth 3 --search-path "${GOPATH}/src" --type d  --exec realpath "{}")
  DOTFILES_PROJECT_DIRS=$(printf "%s\n%s" "${DOTFILES_REPO_PROJECT_DIRS}" "${DOTFILES_GO_PROJECT_DIRS}" | sort -uf)

  mkdir -p "$HOME/.cache/dotfiles"
  touch "$HOME/.cache/dotfiles/recent_projects.txt"

  local recent_projects
  readarray -t recent_projects < "$HOME/.cache/dotfiles/recent_projects.txt"
  local project_dirs=("${DOTFILES_PROJECT_DIRS}")
  tput setaf 8
  for recent_proj in "${recent_projects[@]}"; do
    printf "%s\n" "${recent_proj}"
    project_dirs=("${project_dirs[@]/$recent_proj}")
  done
  tput setaf 7
  printf "%s/gitrepos\n" "${HOME}"
  printf "%s/repos\n" "${HOME}"
  printf "%s\n" "${project_dirs[@]}" | gsed -e /^$/d
}

ms_cd_project() {
  mkdir -p "$HOME/.cache/dotfiles"
  local cache="$HOME/.cache/dotfiles/recent_projects.txt"
  touch "$cache"
  if (( $# != 1 )); then
    ms_err "no project name provided"
    return 1
  fi
  project="$1" 
  project_path=$(ms_ls_projects | ansifilter | grep -E -m 1 "${project%/}\$")
  if [[ -z "$project_path" ]]; then
    ms_err "could not find project"
    return 1
  fi

  printf '%s\n%s\n' "$project_path" "$(cat "$cache")" >"$cache"
  # remove duplicates
  gawk -i inplace '!seen[$0]++' "$cache"

  if ! cd "$project_path" 2>/dev/null; then
    ms_err "could not find project $project_path"
    # replace with blank line for removal
    gsed -i -e "s|$project_path||g" "$cache"
  fi

  # limit to 20 lines, remove base repos and blank lines
  gsed -i -e '21,$ d' -e "s|^$HOME/.*repos$||" -e /^$/d "$cache"

}

ms_nvim_dirs() {
  plugin_configs=$(find "$HOME/.config/nvim/lua/plugins" -maxdepth 1)
  mason_packages=$(find "$HOME/.local/share/nvim/mason/packages" -maxdepth 1)
  nvim_plugins="$(fd --max-depth 5 --hidden --no-ignore --glob --prune --search-path "$HOME/.local/share/nvim/lazy" '.git' --exec realpath {//})"
  local nvim_dirs=(
    "$HOME/.config/nvim" 
    "$HOME/.config/kitty-nvim" 
    "$plugin_configs"
    "$HOME/.local/share/nvim" 
    "$HOME/.local/share/nvim/render" 
    "$HOME/.local/state/nvim" 
    "$HOME/.local/state/nvim/swap"
    "$HOME/.local/state/nvim/undo"
    "$HOME/.local/state/nvim/backup"
    "$HOME/gitrepos/gruvsquirrel/"
    "$HOME/.local/share/nvim/lazy" 
    "$nvim_plugins"
    "$mason_packages"
  )

  for nvim_dir in "${nvim_dirs[@]}"; do
    echo "$nvim_dir"
  done
}

function with_role () {
	ROLE=""
	if [[ "$@" == "bc-bolt-prod" ]]
	then 
		ROLE="arn:aws:iam::605045604850:role/dev-admin"
	elif [[ "$@" == "bc-bolt-dev" ]]
	then 
		ROLE="arn:aws:iam::345835502413:role/dev-admin"
	elif [[ "$@" == "bc-videocloud-prod" ]]
        then
		ROLE="arn:aws:iam::749779118921:role/dev-admin"
	else 
		echo "you need to say whether to use bc-bolt-dev or bc-bolt-prod or bc-videocloud-prod"
	fi
	if [ "$ROLE" != "" ]
	then 
		echo "Generating Temporary Session Creds..." >&2
		CREDS=$(aws sts assume-role \
		--profile "dev-admin@${@}" \
		--role-arn $ROLE \
		--role-session-name "${USER}-session" \
		--query Credentials \
		--output text \
    --duration-seconds 3600 # max of 1 hour is set by admin
  )
		if [ -n "$ZSH_VERSION" ]
		then
			TEMP_EXPIRATION=$(echo ${=CREDS} | cut -d " " -f 2)
			export AWS_ACCESS_KEY_ID=$(echo ${=CREDS} | cut -d " " -f 1)
			export AWS_SECRET_ACCESS_KEY=$(echo ${=CREDS} | cut -d " " -f 3)
			export AWS_SESSION_TOKEN=$(echo ${=CREDS} | cut -d " " -f 4)
		else
			TEMP_EXPIRATION=$(echo ${CREDS} | cut -d " " -f 2)
			export AWS_ACCESS_KEY_ID=$(echo ${CREDS} | cut -d " " -f 1)
			export AWS_SECRET_ACCESS_KEY=$(echo ${CREDS} | cut -d " " -f 3)
			export AWS_SESSION_TOKEN=$(echo ${CREDS} | cut -d " " -f 4)
		fi
		echo "Generated Creds. Will Expire in 1 hour @ ${TEMP_EXPIRATION}" >&2
		${@:3}
	fi
}

# if remote exists and is in the standard list then return in list
ms_git_with_standard_remotes() {
  local fetch_remotes=('origin' 'upstream' 'mike')
  local remotes=$(git remote 2>/dev/null)
  # https://unix.stackexchange.com/questions/104837/intersection-of-two-arrays-in-bash
  local intersection=($(comm -12 <(printf '%s\n' "${fetch_remotes[@]}" | LC_ALL=C sort -uf) <(printf '%s\n' "${remotes[@]}" | LC_ALL=C sort -uf)))
  printf "%s " "${intersection[@]}"
}

ms_arr_dedup_sort() {
  # https://stackoverflow.com/questions/13648410/how-can-i-get-unique-values-from-an-array-in-bash
  local items=($@)
  IFS=" " read -r -a items <<< "$(tr ' ' '\n' <<< "${items[@]}" | sort -u | tr '\n' ' ')"
  printf "%s " ${items[@]}
}

ms_git_f() {
  local args=($@)
  local remotes=($(ms_git_with_standard_remotes) ${args[@]})
  local remotes_to_fetch
  printf -v remotes_to_fetch "%s " "$(ms_arr_dedup_sort ${remotes[@]})"
  if [[ -n "${remotes_to_fetch// }" ]] then
    local fetch_options
    printf -v fetch_options -- "--multiple --jobs=5 -v %s" "${remotes_to_fetch}"
    git fetch ${fetch_options} 2>&1 | grep -Ev "^\s=" # ignore lines starting with = which indicate up-to-date
    local return_codes=("${PIPESTATUS[@]}")
    local fetch_return_code=${return_codes[0]}
    local grep_return_code=${return_codes[1]}
    if (( fetch_return_code )); then
      return ${fetch_return_code}
    fi
    if (( ${grep_return_code} < 0 )) || (( ${grep_return_code} > 1)); then
      return ${grep_return_code}    
    fi
  else
    msg='oops, not a git repo'
    if command -v fortune &> /dev/null;then
      msg=$(fortune computers)
    fi
    if command -v cowsay &> /dev/null;then
      msg=$(cowsay "$msg")
    fi
    if command -v lolcat &> /dev/null;then
      lolcat --force <<< "$msg"
    else
      echo "$msg"
    fi
    return 148
  fi
}

ms_git_cibr() {
  local branch
  branch="$(git cbr)"
  if [[ "$branch" =~ ^.*[^A-Z]([A-Z]+\-[0-9]+).*$ ]] || [[ "$branch" =~ ^([A-Z]+\-[0-9]+).*$ ]]; then
    local msg
    msg=$(printf "%s: " "${BASH_REMATCH[1]}")
    git ci --edit --cleanup=verbatim --message="$msg" "$@"
    return $?
  fi
  return 1
}


# thanks https://github.com/kalgynirae/dotfiles/blob/1203030bd44448088c4c1a42155a254171a31c4b/bashrc#L59
# Test the terminal's text/color capabilities
colortest() {
  local color escapes intensity style
  echo "NORMAL bold  dim   itali under rever strik  BRIGHT bold  dim   itali under rever strik"
  for color in $(seq 0 7); do
    for intensity in 3 9; do  # normal, bright
      escapes="${intensity}${color}"
      printf '\e[%sm\\e[%sm\e[0m ' "$escapes" "$escapes" # normal
      for style in 1 2 3 4 7 9; do  # bold, dim, italic, underline, reverse, strikethrough
        escapes="${intensity}${color};${style}"
        printf '\e[%sm\\e[%sm\e[0m ' "$escapes" "$style"
      done
      echo -n " "
    done
    echo
  done
  echo -n "TRUECOLOR "
  awk 'BEGIN{
    columns = 78;
    step = columns / 6;
    for (hue = 0; hue<columns; hue++) {
      x = (hue % step) * 255 / step;
      if (hue < step) {
        r = 255; g = x; b = 0;
      } else if (hue < step*2) {
        r = 255-x; g = 255; b = 0;
      } else if (hue < step*3) {
        r = 0; g = 255; b = x;
      } else if (hue < step*4) {
        r = 0; g = 255-x; b = 255;
      } else if (hue < step*5) {
        r = x; g = 0; b = 255;
      } else {
        r = 255; g = 0; b = 255-x;
      }
      printf "\033[48;2;%d;%d;%dm", r, g, b;
      printf "\033[38;2;%d;%d;%dm", 255-r, 255-g, 255-b;
      printf " \033[0m";
    }
    printf "\n";
  }'
}

function wt () {
  cd "$(git worktree list | awk '{ for (i=NF; i>0; i--) printf("%s ",$i); printf("\n")}' | fzf | awk '{ print $NF }' )" || true
}

# from https://github.com/junegunn/fzf/wiki/Examples#homebrew
# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]ackage
bip() {
  local inst
  inst=$(brew search "$@" | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst); do
      brew install $prog
    done
  fi
}


oldvim() {
	export MYVIMRC="$XDG_CONFIG_HOME/vim/.vimrc"
	# shellcheck disable=SC2034
	export VIMINIT=":set runtimepath+=$XDG_CONFIG_HOME/vim/|:source $MYVIMRC"
	# clear vim runtime to avoid neovim conflict
	export VIMRUNTIME=''
	eval "$(which vim)" "$@"
}

vim8() {
	export MYVIMRC="$XDG_CONFIG_HOME/vim8*/.vimrc"
	# shellcheck disable=SC2034
	export VIMINIT=":set runtimepath+=$XDG_CONFIG_HOME/vim8*/|:source $MYVIMRC"
	# clear vim runtime to avoid neovim conflict
	export VIMRUNTIME="$HOME/gitrepos/vim/runtime"
	eval "$HOME/gitrepos/vim/src/vim" "$@"
}


# if not arguments are provided navigate to the root of the git repository
g() {
	if [ $# -eq 0 ]; then
		cd "$(git root)" || return
	else
		git "$@"
	fi
}


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

k9s() {
	k9s_cmd='/opt/homebrew/bin/k9s'
	if [[ "$1" == '' ]] || [[ "$1" == '-'* ]]; then
		$k9s_cmd --screen-dump-dir "$XDG_DATA_HOME/k9s/screens" --logFile "$XDG_DATA_HOME/k9s/k9s.log" "$@"
	elif [[ "$1" == 'info' ]]; then
		if command -v lolcat &>/dev/null; then
			eval "$k9s_cmd info" | head -8
			eval "$k9s_cmd info" | tail -2 | gsed -e "s|\(^.*Screen Dumps:.*[[:space:]]\+\)\/.*$|\1$XDG_DATA_HOME/k9s/screens|g" \
				-e "s|\(^.*Logs:.*[[:space:]]\+\)\/.*$|\1$XDG_DATA_HOME/k9s/k9s.log|g" | lolcat --force
			printf "\n ⚠️  Logs and Screen Dumps file are overridden ⚠️\\n     by a custom k9s function wrapper \n"
		else
			eval "$k9s_cmd info" | gsed -e "s|\(^.*Screen Dumps:.*[[:space:]]\+\)\/.*$|\1$XDG_DATA_HOME/k9s/screens|g" \
				-e "s|\(^.*Logs:.*[[:space:]]\+\)\/.*$|\1$XDG_DATA_HOME/k9s/k9s.log|g"
			printf "\n ⚠️  Logs and Screen Dumps file are overridden ⚠️\\n     by a custom k9s function wrapper \n"
		fi
	elif [[ "$1" == 'screens' ]]; then
		ctx="$(kubectl config current-context)"
		cd "$XDG_DATA_HOME/k9s/screens/$ctx" || exit 1
	elif [[ "$1" == 'lastscreen' ]]; then
		ctx="$(kubectl config current-context)"
		ctx_dir="$XDG_DATA_HOME/k9s/screens/$ctx"
		last_screen="$ctx_dir/$(ls -1rt $ctx_dir | tail -1)"
		nvim "$last_screen"
	elif [[ "$1" == 'logs' ]]; then
		nvim "$XDG_DATA_HOME/k9s/k9s.log"
	else
		$k9s_cmd "$@"
	fi
}

p() {
	if ((!$#)); then
		local directory
		directory="$(ms_ls_projects | fzf --ansi --no-multi --prompt=' ' --border-label=' Projects ' \
      --header $' <\e[33;5mctrl-x\e[m> to \e[m\e[31;5mRemove from recent projects' \
      --bind='ctrl-x:execute(ms_remove_recent_project {})+abort' \
                )"
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
		path="$(ms_nvim_dirs | fzf --ansi --prompt=' ' --border-label=' Neovim Directories ')"
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
	local directory
  directory="$(ms_nvim_dirs | fzf)"
	if [[ $directory != "" ]]; then
		cd "$directory" || return
	fi
}

