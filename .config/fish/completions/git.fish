source $__fish_data_dir/completions/git.fish

complete --command git --condition '__fish_git_using_command dt diffview' --keep-order --exclusive --arguments '(complete --do-complete "git difftool ")'
