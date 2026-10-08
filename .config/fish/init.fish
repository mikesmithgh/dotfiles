#!/usr/bin/env fish
# one time idempotent setup for shell

if test (uname) != Darwin
    echo "Expecting MacOS, no init for you!"
    exit 1
end

mkdir -p "$HOME/.local/state/fzf/"
touch "$HOME/.local/state/fzf/history.txt"

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

# disable clicking wallpaper to show desktop
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# enable auto hiding of the dock
defaults write com.apple.dock autohide -bool true

# disable Displays have separate Spaces
defaults write com.apple.spaces spans-displays -bool true

# disable Drag windows to top of screen to enter Mission Control
defaults write com.apple.dock enter-mission-control-by-top-window-drag -bool false

# disable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# iPhone simulator save screenshots to screenshots directory
defaults write com.apple.iphonesimulator ScreenShotSaveLocation -string ~/Pictures/screenshots
defaults write com.apple.dt.Devices ScreenShotSaveLocation -string ~/Pictures/screenshots

set login_shell (which fish)
echo "Setting login shell to $login_shell, current shell $SHELL"
# if login shell is not present in /etc/shells then add it
if not grep -qxF $login_shell /etc/shells
    echo $login_shell | sudo tee -a /etc/shells >/dev/null
end
chsh -s $login_shell

echo "Restart may be required for changes to take effect"
