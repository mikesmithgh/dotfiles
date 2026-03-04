function favorites
    if test -n (commandline)
        commandline --function forward-char
    else
        set --local dirs \
            ~/ \
            ~/repos/ \
            ~/gitrepos/ \
            ~/Pictures/screenshots/ \
            ~/Pictures/screenshots/starstruck/ \
            ~/scripts/

        set --local dir (printf '%s\n' $dirs | fzf)
        if test $status -ne 0
            commandline -a '
        '
            ms_err '%s\n' $dir
            commandline -f cancel-commandline
            return $status
        end
        if test -n "$dir"
            commandline -f repaint
            y $dir
        end
    end
    return 0
end
