#!/opt/homebrew/bin/bash
set -eu

if [ "$#" -eq 3 ]; then
	INPUT_LINE_NUMBER=${1:-0}
	CURSOR_LINE=${2:-1}
	CURSOR_COLUMN=${3:-1}
	AUTOCMD_TERMCLOSE_CMD="call cursor(max([0,${INPUT_LINE_NUMBER}-1])+${CURSOR_LINE}, ${CURSOR_COLUMN})"
else
	AUTOCMD_TERMCLOSE_CMD="normal G"
fi

# create a temporary named pipe
rm -rf /tmp/doo
mkfifo /tmp/doo
chmod 777 /tmp/doo

# cat /tmp/doo /tmp/doo <&0
# sleep 2

exec nvim \
	-u NONE \
	-c "map <silent> q :qa!<CR>" \
	-c "set shell=bash scrollback=100000 termguicolors laststatus=0 clipboard+=unnamedplus" \
	-c "autocmd TermEnter * stopinsert" \
	-c "autocmd TermClose * ${AUTOCMD_TERMCLOSE_CMD}" \
	-c 'terminal sed </tmp/doo -e "s/'$'\x1b'']8;;file:[^\]*[\]//g" && sleep 0.01 && printf "'$'\x1b'']2;"' /tmp/doo <&0 0</dev/null
