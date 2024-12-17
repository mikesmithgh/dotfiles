function fish_user_key_bindings
    bind \cP p
    bind \cN n
    bind \co toggle_nvim_prefix
    bind \cf favorites


    # override alt-left,alt-right to force a redraw of the prompt
    bind \e\[1\;3C next_dir
    bind \e\[1\;3D back_dir
end
