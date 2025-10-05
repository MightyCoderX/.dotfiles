function fish_greeting
    asmfetch
    printf '\n\n'
    fortune -s
    printf '\n'

    if set -q fish_private_mode
        set -l line (_ "fish is running in private mode, history will not be persisted.")
        if set -q fish_greeting[1]
            set -g fish_greeting $fish_greeting\n$line
        else
            set -g fish_greeting $line
        end
        test -n "$fish_greeting"
        and echo $fish_greeting
    end
end
