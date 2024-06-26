function next_dir
    if test -n (commandline)
        commandline --function nextd-or-forward-word
    else
        nextd
        commandline -f repaint
    end
end
