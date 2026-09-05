# ssh-agent: reuse an existing agent instead of spawning a new one per shell
SSH_ENV="$HOME/.ssh/agent-environment"

start_ssh_agent() {
  eval "$(ssh-agent -s)" >/dev/null
  echo -e "SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SSH_AUTH_SOCK;\nSSH_AGENT_PID=$SSH_AGENT_PID; export SSH_AGENT_PID;" >"$SSH_ENV"
  chmod 600 "$SSH_ENV"
}

if [ -f "$SSH_ENV" ]; then
  . "$SSH_ENV" >/dev/null
fi
if [ -z "$SSH_AGENT_PID" ] || ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
  start_ssh_agent
fi
