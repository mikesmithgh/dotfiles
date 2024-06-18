# modified https://github.com/fish-shell/fish-shell/blob/616ca8379901ba60e54e1aaf765e2e3b04d909d0/share/functions/__fish_list_current_token.fish
function __fish_list_current_token -d "List contents of token under the cursor if it is a directory, otherwise list the contents of the current directory"
    set -l val (commandline -t | string replace -r '^~' "$HOME")
    set -l cmd
    if test -d $val
        set cmd ls $val
    else
        set -l dir (dirname -- $val)
        if test $dir != . -a -d $dir
            set cmd l $dir
        else
            set cmd l
        end
    end
    commandline -f repaint
end
