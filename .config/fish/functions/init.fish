function init --description "one time idempotent setup for shell"
    mkdir -p "$HOME/.local/state/fzf/"
    touch "$HOME/.local/state/fzf/history.txt"

    if test (uname) = Darwin
        # 15 is lowest setting on UI
        # 8 was too fast causing duplicate keystrokes
        # 10 i think this causes issues in bash cli when editing commands, not sure
        defaults write -g InitialKeyRepeat -int 12

        # 2 is lowest setting on UI
        defaults write -g KeyRepeat -int 2

        # allow holding key instead of mac default holding key to choose alternate key
        defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

        # holding ctrl+cmd and using the mouse drags the window
        defaults write -g NSWindowShouldDragOnGesture yes

        # rectangle configuration for centered window <command-m> see https://github.com/rxhanson/Rectangle/blob/master/TerminalCommands.md#add-an-extra-centering-command-with-custom-size
        defaults write com.knollsoft.Rectangle specified -dict-add keyCode -float 46 modifierFlags -float 1048840
        defaults write com.knollsoft.Rectangle specifiedWidth -float 2000
        defaults write com.knollsoft.Rectangle specifiedHeight -float 800
    end

end
