function open --description 'Open files quietly and completely detached'
    for file in $argv
        # Force xdg-open to run in the background with silenced output
        command xdg-open $file >/dev/null 2>&1 &
        # Immediately untether the background job from this shell session
        disown
    end
end
