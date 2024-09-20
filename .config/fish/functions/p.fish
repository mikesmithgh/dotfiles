function p
    set --local dir (ms_fzf_project $argv)
    if test -n "$dir"
        cd $dir
        commandline -f repaint
    end
    return 0
end
