function kubectl
    if not set real_kubectl (which kubectl)
        printf 'fish: Unknown command: kubectl\n' >&2
        return 1
    end
    if count $argv >/dev/null
        $real_kubectl $argv
    else
        $real_kubectl config unset current-context >/dev/null
    end
end
