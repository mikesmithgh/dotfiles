# add the following function and bindings to your fish config (e.g., ~/.config/fish/config.fish) 

function kitty_scrollback_edit_command_buffer
    set -lx VISUAL '/Users/mike/gitrepos/kitty-scrollback.nvim/scripts/edit_command_line.sh'
    edit_command_buffer
    commandline ''
end

bind --mode default \ee kitty_scrollback_edit_command_buffer
# bind --mode default \ev kitty_scrollback_edit_command_buffer

bind --mode visual \ee kitty_scrollback_edit_command_buffer
# bind --mode visual \ev kitty_scrollback_edit_command_buffer

bind --mode insert \ee kitty_scrollback_edit_command_buffer
# bind --mode insert \ev kitty_scrollback_edit_command_buffer

# [optional] pass arguments to kitty-scrollback.nvim in command-line editing mode
# by using the environment variable KITTY_SCROLLBACK_NVIM_EDIT_ARGS
# set -gx KITTY_SCROLLBACK_NVIM_EDIT_ARGS ''
