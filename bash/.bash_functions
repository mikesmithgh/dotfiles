#!/usr/bin/env bash

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

n() {
  path=$(ms_fzf_config "$@")
  if [[ -d "$path" ]]; then
    cd "$path" || return
  else
    cd "$(dirname "$path")" || return
    $VISUAL "$path"
  fi
}

p() {
  cd $(ms_fzf_project "$@")
}
