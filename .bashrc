#!/usr/bin/env bash
# This file runs every time you open a new terminal window.

# Limit number of lines and entries in the history. HISTFILESIZE controls the
# history file on disk and HISTSIZE controls lines stored in memory.
export HISTFILESIZE=50000
export HISTSIZE=50000

# Add a timestamp to each command.
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

# Duplicate lines and lines starting with a space are not put into the history.
export HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# Ensure $LINES and $COLUMNS always get updated.
shopt -s checkwinsize

# Enable bash completion.
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Improve output of less for binary files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Load aliases if they exist.
[ -f "${HOME}/.aliases" ] && source "${HOME}/.aliases"
[ -f "${HOME}/.aliases.local" ] && source "${HOME}/.aliases.local"

# Determine git branch.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Set a non-distracting prompt.
PS1='\[[01;32m\]\u@\h\[[00m\]:\[[01;34m\]\w\[[00m\] \[[01;33m\]$(parse_git_branch)\[[00m\]\$ '

# If it's an xterm compatible terminal, set the title to user@host: dir.
case "${TERM}" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]${PS1}"
    ;;
*)
    ;;
esac

# Enable asdf to manage various programming runtime versions.
#   Requires: https://asdf-vm.com/#/
source "${HOME}"/.asdf/asdf.sh

# Enable a better reverse search experience.
#   Requires: https://github.com/junegunn/fzf (to use fzf in general)
#   Requires: https://github.com/BurntSushi/ripgrep (for using rg below)
export FZF_DEFAULT_COMMAND="rg --files --hidden --no-ignore --follow --glob '!.git'"
export FZF_DEFAULT_OPTS="--color=dark"
export FZF_TMUX_OPTS="-d 33%"
[ -f "${HOME}/.fzf.bash" ] && source "${HOME}/.fzf.bash"

# WSL 2.
# Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3 }'):0"

# Allows your gpg passphrase prompt to spawn (useful for signing commits).
export GPG_TTY=$(tty)

export LIBGL_ALWAYS_INDIRECT=1

eval "$(keychain --eval --quiet id_ed25519)"

# pnpm
export PNPM_HOME="/home/greg/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export CMAKE_FILEPATH="/home/greg/.asdf/shims/cmake"
export NINJA_FILEPATH="/home/greg/bin/ninja/ninja"
export VCPKG_ROOT="/home/greg/bin/vcpkg/"

# kubectl completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/greg/google-cloud-sdk/path.bash.inc' ]; then . '/home/greg/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/greg/google-cloud-sdk/completion.bash.inc' ]; then . '/home/greg/google-cloud-sdk/completion.bash.inc'; fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(oh-my-posh init bash --config $(brew --prefix oh-my-posh)/themes/jandedobbeleer.omp.json)"
