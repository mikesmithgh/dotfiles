function toggle_nvim_prefix
    set command (commandline)
    if string match --quiet --regex '^\s*nvim*' $command
        set trimmed_command (string replace --regex '^\s*nvim*' '' $command)
        set trimmed_command (string replace --regex '^\s*' '' $trimmed_command)
        set cursor_pos (commandline -C)
        commandline -C 0
        commandline $trimmed_command
        set new_cursor_pos (math $cursor_pos - 5)
        if test $new_cursor_pos -lt 0
            set new_cursor_pos 0
        end
        commandline -C $new_cursor_pos
    else
        # Save the current command line content
        set cursor_pos (commandline -C)
        commandline -C 0
        commandline -i 'nvim '
        commandline -C (math $cursor_pos + 5)
    end
end
