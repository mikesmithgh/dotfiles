function init --description "one time idempotent setup for shell"
    mkdir -p "$HOME/.local/state/fzf/"
    touch "$HOME/.local/state/fzf/history.txt"
end
