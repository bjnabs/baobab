#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : git.sh
# Purpose     : Configures Git for the BAOBAB Development Environment.
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

log_header "Git Configuration"

###############################################################################
# Verify Git
###############################################################################

log_section "Git Installation"

if ! command_exists git; then
    log_error "Git is not installed."
    exit 1
fi

log_info "$(git --version)"

###############################################################################
# Default Configuration
###############################################################################

log_section "Git Defaults"

git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global fetch.prune true
git config --global push.autoSetupRemote true
git config --global core.editor "code --wait"
git config --global core.autocrlf input
git config --global core.filemode false
git config --global core.ignorecase false
git config --global color.ui auto

log_success "Git defaults configured."

###############################################################################
# Git Identity
###############################################################################

log_section "Git Identity"

NAME="$(git config --global user.name || true)"
EMAIL="$(git config --global user.email || true)"

if [[ -n "${NAME}" ]]; then
    log_info "User Name : ${NAME}"
else
    log_warning "Git user.name has not been configured."
fi

if [[ -n "${EMAIL}" ]]; then
    log_info "User Email: ${EMAIL}"
else
    log_warning "Git user.email has not been configured."
fi

###############################################################################
# GitHub CLI
###############################################################################

log_section "GitHub CLI"

if command_exists gh; then

    log_info "$(gh --version | head -n 1)"

    if gh auth status >/dev/null 2>&1; then
        log_success "GitHub CLI authenticated."
    else
        log_warning "GitHub CLI is not authenticated."
    fi

else

    log_warning "GitHub CLI is not installed."

fi

###############################################################################
# Repository
###############################################################################

log_section "Repository"

PROJECT_ROOT="$(get_project_root)"

cd "${PROJECT_ROOT}"

if git rev-parse --git-dir >/dev/null 2>&1; then

    CURRENT_BRANCH="$(git branch --show-current)"

    log_info "Repository detected."
    log_info "Current Branch: ${CURRENT_BRANCH}"

else

    log_warning "Current directory is not a Git repository."

fi

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Git configuration completed successfully."

exit 0
