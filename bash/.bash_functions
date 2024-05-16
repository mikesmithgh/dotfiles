#!/usr/bin/env bash

ms_cd_project() {
	mkdir -p "$HOME/.cache/dotfiles"
	local cache="$HOME/.cache/dotfiles/recent_projects.txt"
	touch "$cache"
	if (($# != 1)); then
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
	IFS=" " read -r -a items <<<"$(tr ' ' '\n' <<<"${items[@]}" | sort -u | tr '\n' ' ')"
	printf "%s " ${items[@]}
}

ms_git_f() {
	local args=($@)
	local remotes=($(ms_git_with_standard_remotes) ${args[@]})
	local remotes_to_fetch
	printf -v remotes_to_fetch "%s " "$(ms_arr_dedup_sort ${remotes[@]})"
	if [[ -n "${remotes_to_fetch// /}" ]]; then
		local fetch_options
		printf -v fetch_options -- "--multiple --jobs=5 -v %s" "${remotes_to_fetch}"
		git fetch ${fetch_options} 2>&1 | grep -Ev "^\s=" # ignore lines starting with = which indicate up-to-date
		local return_codes=("${PIPESTATUS[@]}")
		local fetch_return_code=${return_codes[0]}
		local grep_return_code=${return_codes[1]}
		if ((fetch_return_code)); then
			return ${fetch_return_code}
		fi
		if ((${grep_return_code} < 0)) || ((${grep_return_code} > 1)); then
			return ${grep_return_code}
		fi
	else
		msg='oops, not a git repo'
		if command -v fortune &>/dev/null; then
			msg=$(fortune computers)
		fi
		if command -v cowsay &>/dev/null; then
			msg=$(cowsay "$msg")
		fi
		if command -v lolcat &>/dev/null; then
			lolcat --force <<<"$msg"
		else
			echo "$msg"
		fi
		return 148
	fi
}

function wt() {
	cd "$(git worktree list | awk '{ for (i=NF; i>0; i--) printf("%s ",$i); printf("\n")}' | fzf | awk '{ print $NF }')" || true
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
	nvim -c "lua vim.api.nvim_create_autocmd({ 'User' }, {
                  group = vim.api.nvim_create_augroup('NewNoteOpenNvimTree', { clear = true }),
                  pattern = { 'VeryLazy' },
                  callback = function()
                    vim.cmd.NvimTreeOpen()
                    vim.cmd.wincmd('l')
                  end,
                })" \
		"${latest_file}"
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
		nvim -c "lua vim.api.nvim_create_autocmd({ 'User' }, {
                  group = vim.api.nvim_create_augroup('NewNoteOpenNvimTree', { clear = true }),
                  pattern = { 'VeryLazy' },
                  callback = function()
                    vim.cmd.NvimTreeOpen()
                    vim.cmd.wincmd('l')
                  end,
                })" \
			"${filename}.${fileext}"
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
		nvim -c "lua vim.api.nvim_create_autocmd({ 'User' }, {
                  group = vim.api.nvim_create_augroup('NewNoteOpenNvimTree', { clear = true }),
                  pattern = { 'VeryLazy' },
                  callback = function()
                    vim.cmd.NvimTreeOpen()
                    vim.cmd.wincmd('l')
                  end,
                })" \
			"${filename}${fileext}"
	else
		echo "missing filename parameter"
	fi
}

p() {
	if ((!$#)); then
		local directory
		directory="$(
			ms_ls_projects | fzf --ansi --no-multi --prompt=' ' --border-label=' Projects ' \
				--header $' <\e[33mctrl-x\e[m> to \e[m\e[31mRemove from recent projects' \
				--bind='ctrl-x:execute(ms_remove_recent_project {})+abort'
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
