# copy_function() {   test -n "$(declare -f "$1")" || return ;   eval "${_/$1/$2}"; }
# copy_function _ksi_prompt_command _orig_ksi_prompt_command

function row
{
    local COL
    local ROW
    IFS=';' read -sdR -p $'\E[6n' ROW COL
    echo "${ROW#*[}"
}

_ksi_prompt_command() {
  _orig_ksi_prompt_command >/dev/null 2>&1
  (sleep 0.1 && kitty @ launch --type background --stdin-source=@screen_scrollback --stdin-add-formatting /Users/mike/bin/recordit.sh >/dev/null 2>&1 &)

  cols="$(tput cols)"
  rows="$(tput lines)"
  cur_row=$(($(row) - 1))
  printf "%s\n%s\n%s" "$cur_row" "$cols" "$rows"  > /Users/mike/bin/sbnvimpos.txt
}

