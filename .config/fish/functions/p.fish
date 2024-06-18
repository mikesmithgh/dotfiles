function p
    # TODO: bit of a hack at the moment
    builtin cd (ms_fzf_project $argv)
    commandline -f repaint
    return 0
end
