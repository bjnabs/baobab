#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : permissions.sh
# Purpose     : Applies standard file and directory permissions to the BAOBAB
#               workspace.
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

log_header "Workspace Permissions"

PROJECT_ROOT="$(get_project_root)"

###############################################################################
# Validate Workspace
###############################################################################

log_section "Workspace"

if [[ ! -d "${PROJECT_ROOT}" ]]; then
    log_error "Workspace not found."
    exit 1
fi

###############################################################################
# Make Shell Scripts Executable
###############################################################################

log_section "Shell Scripts"

SCRIPT_ROOT="${PROJECT_ROOT}/.devcontainer/docker/scripts"

if [[ -d "${SCRIPT_ROOT}" ]]; then

    find "${SCRIPT_ROOT}" -type f -name "*.sh" -exec chmod +x {} \;

    log_success "Shell scripts are executable."

else

    log_warning "Scripts directory not found."

fi

###############################################################################
# Make Utility Scripts Executable
###############################################################################

log_section "Repository Scripts"

REPOSITORY_SCRIPTS="${PROJECT_ROOT}/infrastructure/scripts"

if [[ -d "${REPOSITORY_SCRIPTS}" ]]; then

    find "${REPOSITORY_SCRIPTS}" -type f -name "*.sh" -exec chmod +x {} \;

    log_success "Infrastructure scripts are executable."

else

    log_info "No infrastructure scripts found."

fi

###############################################################################
# Directory Permissions
###############################################################################

log_section "Directory Permissions"

find "${PROJECT_ROOT}" \
    -type d \
    -exec chmod 755 {} \;

log_success "Directory permissions updated."

###############################################################################
# File Permissions
###############################################################################

log_section "File Permissions"

find "${PROJECT_ROOT}" \
    -type f \
    ! -name "*.sh" \
    -exec chmod 644 {} \;

log_success "File permissions updated."

###############################################################################
# Git Executable Bit
###############################################################################

log_section "Git Index"

cd "${PROJECT_ROOT}"

git update-index --refresh >/dev/null 2>&1 || true

log_success "Git index refreshed."

###############################################################################
# Summary
###############################################################################

log_blank
log_success "Workspace permissions configured successfully."

exit 0
