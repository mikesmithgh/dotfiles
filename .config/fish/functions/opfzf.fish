function opfzf

    set -l n (set_color normal)
    set -l y (set_color yellow)
    set -l r (set_color red)

    # Match fzf's own header color for the "(vault)" part: pull "header:#xxxxxx"
    # out of FZF_DEFAULT_OPTS if it defines one, otherwise use normal color.
    set -l h $n
    set -l header_hex (string match -rg 'header:#?([0-9a-fA-F]{3,6})' -- "$FZF_DEFAULT_OPTS")
    test -n "$header_hex"; and set h (set_color $header_hex)

    set -l header (
        printf '%s\n%s\n%s' \
            " <$y""alt-c$n> to $r""Copy username$n" \
            " <$y""alt-C$n> to $r""Copy password$n" \
            " <$y""enter$n> to $r""Show item details$n" \
        | string collect
    )

    # Rendered item detail, shared by the preview and the enter action.
    set -l view 'op item get {2} | bat --plain --paging=never --language=yaml --color=always'

    # Display column: "Title (Vault)" with the parens + vault name in the fzf
    # header color. Second (hidden) column is the item id, used by preview/binds.
    op item list --format=json \
        | jq -r --arg h "$h" --arg n "$n" \
        '.[] | "\(.title) \($h)(\(.vault.name))\($n)\t\(.id)"' \
        | fzf \
        --ansi \
        --delimiter='\t' \
        --with-nth=1 \
        --header "$header" \
        --preview "sleep 0.1; $view" \
        --bind 'alt-c:execute-silent(op item get {2} --fields username | pbcopy)+change-border-label( ✔ copied username )' \
        --bind 'alt-C:execute-silent(op item get {2} --reveal --fields password | pbcopy)+change-border-label( ✔ copied password )' \
        --bind 'focus:change-border-label()' \
        --bind "enter:become($view)"

end
