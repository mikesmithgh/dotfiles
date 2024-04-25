#!/usr/bin/env bash
set -e -o pipefail

git_push_args=("$*") # for example --dry-run

mirror_repos=(
	# public
	'borderline.nvim'
	'dotfiles'
	'fzcf'
	'git-prompt-string'
	'git-prompt-string-lualine.nvim'
	'gruvsquirrel.nvim'
	'homebrew-git-prompt-string'
	'kitty-scrollback.nvim'
	'kitty-scrollback.nvim.wiki'
	'kitty-scrollback.nvimconf'
	'mikesmithgh'
	'nvim'
	'pdubs'
	'render.nvim'
	'render.nvim.wiki'
	'ugbi'
	'vimpromptu'
	# private
	'fonts'
)

source='git@github.com:mikesmithgh'
targets=('git@codeberg.org:mikesmith' 'git@gitlab.com:mikesmithgl')

mirror_dir="$(mktemp -d)/mirror"
mkdir -p "$mirror_dir"
printf 'temporary mirror directory: %s\n' "$mirror_dir"

for repo_name in "${mirror_repos[@]}"; do
	cd "$mirror_dir" || exit 1
	source_repo="$source/$repo_name.git"
	printf 'cloning %s ...\n' "$source_repo"
	git clone --mirror "$source_repo"
	cd "$repo_name.git" || exit 1

	for target in "${targets[@]}"; do
		target_repo="$target/$repo_name.git"
		git remote set-url --push origin "$target_repo"
		printf 'mirroring %s to: %s\n' "$source_repo" "$target_repo"
		printf 'git push --mirror %s\n' "${git_push_args[@]}"
		if ((${#git_push_args[@]})); then
			git push --mirror
		else
			git push --mirror "${git_push_args[@]}"
		fi
	done

done

rm -rf "$mirror_dir"
