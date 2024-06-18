function kitty_scrollback_edit_command_buffer
    set -lx VISUAL '/Users/mike/gitrepos/kitty-scrollback.nvim/scripts/edit_command_line.sh'
    edit_command_buffer
    commandline ''
end
