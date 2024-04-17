#!/usr/bin/env bash

parse_git_host() {
	host="$1"
	# Remove everything before "@" symbol
	temp="${target#*@}"
	# Extract the part before the first occurrence of "."
	host="${temp%%.*}"
	printf '%s' "$host"
}

mirror_repos=('dotfiles')

source='git@github.com:mikesmithgh'
targets=('git@codeberg.org:mikesmith' 'git@gitlab.com:mikesmithgl')

branch='main'

mirror_dir="$(mktemp -d)/mirror"
mkdir -p "$mirror_dir"
printf 'temporary mirror directory: %s\n' "$mirror_dir"

for repo_name in "${mirror_repos[@]}"; do
	cd "$mirror_dir" || exit 1
	source_repo="$source/$repo_name.git"
	printf 'cloning %s ...\n' "$source_repo"
	git clone "$source_repo"
	cd "$repo_name" || exit 1
	git checkout "$branch"

	for target in "${targets[@]}"; do
		upstream=$(parse_git_host "$target")
		target_repo="$target/$repo_name.git"
		printf 'adding upstream: %s %s\n' "$upstream" "$target_repo"
		git remote add "$upstream" "$target_repo"
		git push -f "$upstream" "$branch"
	done

done

rm -rf "$mirror_dir"
