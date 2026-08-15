# ~/.bashrc

set noclobber
complete -d cd

# ---------------------------------------------------------------------------
# LESS Options to provide case insensitive search and colorization
# explained - https://youtu.be/D0sG2fj0G4Y
# borrowed heavily from https://grml.org
# ---------------------------------------------------------------------------
export LESS='-miR'

export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[75m'

export MANPAGER='less'


# ---------------------------------------------------------------------------
# Interactive Bash configuration
# ---------------------------------------------------------------------------

# Exit early for non-interactive shells.
case $- in
    *i*) ;;
      *) return ;;
esac

# ===========================================================================
# Utilities & Aliases
# ===========================================================================

[[ -f "$HOME/.bash_utils"   ]] && source "$HOME/.bash_utils"
[[ -f "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"

# ===========================================================================
# PATH
# ===========================================================================

# User-local executables.
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && PATH="$HOME/.local/bin:$PATH"
[[ ":$PATH:" != *":$HOME/bin:"*       ]] && PATH="$HOME/bin:$PATH"

export PATH


# ===========================================================================
# Git Completion / Prompt
# ===========================================================================

# Git completion
if [[ -f /usr/share/bash-completion/completions/git ]]; then
    source /usr/share/bash-completion/completions/git
elif [[ -f /usr/share/bash-completion/git ]]; then
    source /usr/share/bash-completion/git
fi

# Git prompt
if [[ -f /usr/lib/git-core/git-sh-prompt ]]; then
    source /usr/lib/git-core/git-sh-prompt
elif [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# Git prompt status indicators.
#
#   *  unstaged changes
#   +  staged changes
#   %  untracked files
#   $  stashed changes
#
# Upstream status may additionally show divergence from the remote.
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"

# Allow git-prompt to colorize its own status information.
GIT_PS1_SHOWCOLORHINTS=1


# ===========================================================================
# History
# ===========================================================================

HISTSIZE=50000
HISTFILESIZE=100000

# ignorespace:
#   Don't save commands beginning with a space.
#
# ignoredups:
#   Don't save immediately repeated commands.
#
# erasedups:
#   Remove older duplicates and retain the latest occurrence.
HISTCONTROL=ignorespace:ignoredups:erasedups

# Don't record common/noisy commands.
HISTIGNORE="ls:ll:la:l:cd:cd ..:pwd:clear:history:exit"

# Append rather than overwrite history on shell exit.
shopt -s histappend

__history_sync() {
    # Write this shell's new history.
    history -a

    # Read history written by other active shells.
    history -n
}


# ===========================================================================
# Terminal Title
# ===========================================================================

__set_terminal_title() {
    printf '\033]0;%s@%s:%s\007' \
        "$HOSTNAME" \
        "$(uname -s)" \
        "${PWD##*/}"
}


# ===========================================================================
# Prompt
# ===========================================================================

# Prompt colors.
readonly RESET='\[\e[0m\]'
readonly GREEN='\[\e[1;32m\]'
readonly BLUE='\[\e[1;34m\]'
readonly YELLOW='\[\e[1;33m\]'

# Static portions of the prompt.
#
# Example:
#
#   james@ubuntu ~/src/project [git: main *+]
#   $
#
PS1_PREFIX="${GREEN}\u@\h${RESET} ${BLUE}\w${RESET} "
PS1_SUFFIX="${RESET}"$'\$ '

__prompt_command() {
    __history_sync
    __set_terminal_title

    if declare -F __git_ps1 &>/dev/null; then
        # Three-argument __git_ps1 form is intended for use from
        # PROMPT_COMMAND and supports GIT_PS1_SHOWCOLORHINTS.
        __git_ps1 \
            "$PS1_PREFIX" \
            "$PS1_SUFFIX" \
            "${YELLOW}[git: %s]${RESET}"
    else
        # Gracefully fall back if git-prompt isn't installed.
        PS1="${PS1_PREFIX}${PS1_SUFFIX}"
    fi
}

PROMPT_COMMAND=__prompt_command
