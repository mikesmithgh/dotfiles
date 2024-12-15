function fish_user_key_bindings
    bind \cP p
    bind \cN n
    bind \co toggle_nvim_prefix
    bind \cf favorites


    # override alt-left,alt-right to force a redraw of the prompt
    bind \e\[1\;3C next_dir
    bind \e\[1\;3D back_dir

    # kitty-scrollback.nvim
    bind --mode default \ee kitty_scrollback_edit_command_buffer
    bind --mode visual \ee kitty_scrollback_edit_command_buffer
    bind --mode insert \ee kitty_scrollback_edit_command_buffer

end
