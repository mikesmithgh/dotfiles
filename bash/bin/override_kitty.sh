#!/bin/bash
_ksi_prompt_command () { 
    if [[ -n "${_ksi_prompt[ps0]}" ]]; then
        PS0=${PS0//\\\[\\e\]133;k;start_kitty\\a\\\]*end_kitty\\a\\\]};
        PS0="${_ksi_prompt[ps0]}$PS0";
    fi;
    if [[ -n "${_ksi_prompt[ps0_suffix]}" ]]; then
        PS0=${PS0//\\\[\\e\]133;k;start_suffix_kitty\\a\\\]*end_suffix_kitty\\a\\\]};
        PS0="${PS0}${_ksi_prompt[ps0_suffix]}";
    fi;
    if [[ -n "${_ksi_prompt[ps1]}" ]]; then
        PS1=${PS1//\\\[\\e\]133;k;start_kitty\\a\\\]*end_kitty\\a\\\]};
        PS1=${PS1//\\\[\\e\]133;k;start_secondary_kitty\\a\\\]*end_secondary_kitty\\a\\\]};
    fi;
    if [[ -n "${_ksi_prompt[ps1_suffix]}" ]]; then
        PS1=${PS1//\\\[\\e\]133;k;start_suffix_kitty\\a\\\]*end_suffix_kitty\\a\\\]};
    fi;
    if [[ -n "${_ksi_prompt[ps1]}" ]]; then
        if [[ "${_ksi_prompt[mark]}" == "y" && ( "${PS1}" == *"\n"* || "${PS1}" == *'
'* ) ]]; then
            builtin local oldval;
            oldval=$(builtin shopt -p extglob);
            builtin shopt -s extglob;
            PS1=${PS1%@('\n'|'
')*}${_ksi_prompt[secondary_prompt]}${PS1##*@('\n'|'
')};
            builtin eval "$oldval";
        fi;
        PS1="${_ksi_prompt[ps1]}$PS1";
    fi;
    if [[ -n "${_ksi_prompt[ps1_suffix]}" ]]; then
        PS1="${PS1}${_ksi_prompt[ps1_suffix]}";
    fi;
    if [[ -n "${_ksi_prompt[ps2]}" ]]; then
        PS2=${PS2//\\\[\\e\]133;k;start_kitty\\a\\\]*end_kitty\\a\\\]};
        PS2="${_ksi_prompt[ps2]}$PS2";
    fi;
    if [[ "${_ksi_prompt[cwd]}" == "y" ]]; then
        if [[ "${_ksi_prompt[last_reported_cwd]}" != "$PWD" ]]; then
            _ksi_prompt[last_reported_cwd]="$PWD";
            builtin printf "\e]7;kitty-shell-cwd://%s%s\a" "$HOSTNAME" "$PWD";
        fi;
    fi
}
