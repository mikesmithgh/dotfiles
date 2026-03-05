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
  'mikesmithgh.github.io'
  'nvim'
  'pdubs'
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

    # failures during push may be safe to ignore and we want to continue progressing for other remotes
    # example: remote: Forgejo: The deletion of refs/pull/82/merge is skipped as it's an internal reference.
    # example: ! [remote rejected] refs/pull/1/head -> refs/pull/1/head (deny updating a hidden ref)
    #
    # codeberg does not allhow github specific pull request refs, Gitea marks 'refs/pull/*' as hidden refs
    set +e

    if ((${#git_push_args[@]})); then
      git push --mirror
    else
      git push --mirror "${git_push_args[@]}"
    fi

    set -e
  done

done

rm -rf "$mirror_dir"

# suggested setup
# create a cron and add identify file for each git host

# ~/.ssh/config
# Host github.com
#   AddKeysToAgent yes
#   UseKeychain yes
#   IdentityFile ~/.ssh/id_ed25519
#
# Host gitlab.com
#   AddKeysToAgent yes
#   UseKeychain yes
#   IdentityFile ~/.ssh/id_ed25519
#
# Host codeberg.org
#   AddKeysToAgent yes
#   UseKeychain yes
#   IdentityFile ~/.ssh/id_ed25519

# crontab
# 30 2 * * * /.../dotfiles/bash/scripts/github-mirror.sh >> /.../tmp/github-mirror.log 2>&1
