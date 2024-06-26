function p
    # TODO: bit of a hack at the moment
    set --local dir (ms_fzf_project $argv)
    if test -n "$dir"
        cd $dir
        commandline -f repaint
    end
    return 0
end
