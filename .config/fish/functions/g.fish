function g --wraps=git
    if count $argv >/dev/null
        git $argv
    else
        cd $(git root) || return
    end
end
