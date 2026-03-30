if not status is-interactive
    return
end

abbr --add vi nvim
abbr --add vim nvim
abbr --add bnvim bobnvim
abbr --add vimdiff nvim -d
abbr --add k kubectl
abbr --add kx kubectx
abbr --add g git
abbr --add k9sw k9s --write

abbr --add notes "cd $HOME/neorg/notes"
abbr --add sprint "cd $HOME/neorg/notes; nvim (fd --max-depth 1 --type file 'sprint-.*\.norg' | tail -1)"
abbr --add index "cd $HOME/neorg/notes; nvim +'Neorg index'"
