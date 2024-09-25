function p
    set --local dir (ms_fzf_project $argv)
    if test $status -ne 0
        commandline -a '
        '
        ms_err '%s\n' $dir
        commandline -f cancel-commandline
        return $status
    end
    if test -n "$dir"
        cd $dir
        commandline -f repaint
    end
    return 0
end
