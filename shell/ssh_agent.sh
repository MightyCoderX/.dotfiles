if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "${XDG_RUNTIME_DIR}ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    # shellcheck source=/run/user/1000/ssh-agent.env 
    source "${XDG_RUNTIME_DIR}/ssh-agent.env" > /dev/null
fi
