#!/usr/bin/env bash
set -e -o pipefail

function info() {
  printf "INFO "
  printf "$@"
  printf "\n"
}

info "github-mirror started at %-5s" "$(date)"

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
info 'temporary mirror directory: %s' "$mirror_dir"

for repo_name in "${mirror_repos[@]}"; do
  cd "$mirror_dir" || exit 1
  source_repo="$source/$repo_name.git"
  info 'cloning %s ...' "$source_repo"
  info 'git clone --mirror %s' "$source_repo"
  printf '\n'
  git clone --mirror "$source_repo"
  printf '\n'
  cd "$repo_name.git" || exit 1

  for target in "${targets[@]}"; do
    target_host=${target#*@}
    target_host=${target_host%%.*}
    target_repo="$target/$repo_name.git"
    git remote set-url --push origin "$target_repo"
    info "repo=$repo_name host=$target_host"
    info 'mirroring %s to %s' "$source_repo" "$target_repo"
    info 'git push --mirror %s' "${git_push_args[@]}"

    # failures during push may be safe to ignore and we want to continue progressing for other remotes
    # example: remote: Forgejo: The deletion of refs/pull/82/merge is skipped as it's an internal reference.
    # example: ! [remote rejected] refs/pull/1/head -> refs/pull/1/head (deny updating a hidden ref)
    #
    # codeberg does not allhow github specific pull request refs, Gitea marks 'refs/pull/*' as hidden refs
    set +e

    printf '\n'
    if ((${#git_push_args[@]})); then
      git push --mirror
    else
      git push --mirror "${git_push_args[@]}"
    fi
    printf '\n'

    set -e
  done

done

rm -rf "$mirror_dir"

info "github-mirror finished at %-5s\n" "$(date)"

# suggested setup
# create a cron and add identify file for each git host
# this assumes apple keychain has password and is loaded in ssh-agent

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
# 30 2 * * * /.../dotfiles/bash/scripts/github-mirror.sh > /.../tmp/github-mirror.log 2>&1
