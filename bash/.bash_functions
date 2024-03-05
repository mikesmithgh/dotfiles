#!/bin/bash

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


function wt () {
  cd "$(git worktree list | awk '{ for (i=NF; i>0; i--) printf("%s ",$i); printf("\n")}' | fzf | awk '{ print $NF }' )" || true
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
      --header $' <\e[33mctrl-x\e[m> to \e[m\e[31mRemove from recent projects' \
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

