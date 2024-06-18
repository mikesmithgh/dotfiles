function fish_user_key_bindings
    bind \cP p
    bind \cN n

    # kitty-scrollback.nvim
    bind --mode default \ee kitty_scrollback_edit_command_buffer
    bind --mode visual \ee kitty_scrollback_edit_command_buffer
    bind --mode insert \ee kitty_scrollback_edit_command_buffer
end
