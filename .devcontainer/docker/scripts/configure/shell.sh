#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : shell.sh
# Purpose     : Configures the Bash shell for the BAOBAB Development
#               Environment.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ------------------------------------------------------------------------------
# Load Utilities
# ------------------------------------------------------------------------------

# shellcheck source=/dev/null
source "${SCRIPT_DIR}/../utils/colors.sh"
source "${SCRIPT_DIR}/../utils/functions.sh"
source "${SCRIPT_DIR}/../utils/logging.sh"

log_header "Shell Configuration"

BASHRC="${HOME}/.bashrc"

###############################################################################
# BAOBAB Shell Configuration
###############################################################################

log_section "BAOBAB Shell Configuration"

START_MARKER="# >>> BAOBAB SHELL CONFIGURATION >>>"
END_MARKER="# <<< BAOBAB SHELL CONFIGURATION <<<"

if grep -Fq "${START_MARKER}" "${BASHRC}"; then

    log_info "BAOBAB shell configuration already exists."

else

cat >> "${BASHRC}" <<'EOF'

# >>> BAOBAB SHELL CONFIGURATION >>>

###############################################################################
# History
###############################################################################

export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth
shopt -s histappend

###############################################################################
# Aliases
###############################################################################

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cls='clear'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

alias dc='docker compose'
alias dps='docker ps'
alias di='docker images'

alias python='python3'
alias pip='pip3'

###############################################################################
# Prompt
###############################################################################

export PS1='\u@\h:\w\$ '

###############################################################################
# Completion
###############################################################################

if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# <<< BAOBAB SHELL CONFIGURATION <<<

EOF

    log_success "BAOBAB shell configuration added."

fi

###############################################################################
# Reload Shell
###############################################################################

log_section "Reload Shell"

# shellcheck disable=SC1090
source "${BASHRC}"

log_success "Shell configuration reloaded."

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Shell configuration completed successfully."

exit 0
