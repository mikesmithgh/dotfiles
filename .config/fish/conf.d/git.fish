# git alias completions (dt = difftool). Lives in conf.d so it does NOT shadow fish 4.x's embedded git completions.
complete --command git --condition '__fish_git_using_command dt diffview' --keep-order --exclusive --arguments '(complete --do-complete "git difftool ")'
