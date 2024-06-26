function git
    if not set real_git (which git)
        printf 'fish: Unknown command: git\n' >&2
        return 1
    end
    if count $argv >/dev/null
        $real_git $argv
    else
        cd $($real_git root) || return
    end
end
