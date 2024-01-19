#!/bin/bash
# .bash_profile configuration

# source the user's bashrc if it exists
if [ -f "${HOME}/.bashrc" ]; then
	source "${HOME}/.bashrc"
fi
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
