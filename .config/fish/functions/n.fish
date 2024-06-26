# TODO: bit of a hack at the moment
function n
    if set path (ms_fzf_config $argv)
        if test -d $path
            cd $path || return 1
        else
            cd (path dirname $path) || return 1
            $VISUAL $path
        end
        commandline -f repaint
    end
end
