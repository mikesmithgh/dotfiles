function back_dir
    if test -n (commandline)
        commandline --function prevd-or-backward-word
    else
        prevd
        commandline --function repaint
    end
end
