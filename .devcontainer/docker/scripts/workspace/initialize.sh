#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : initialize.sh
# Purpose     : Initializes the BAOBAB workspace after the development
#               environment has been provisioned.
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

log_header "Workspace Initialization"

PROJECT_ROOT="$(get_project_root)"

###############################################################################
# Verify Workspace
###############################################################################

log_section "Workspace"

if [[ ! -d "${PROJECT_ROOT}" ]]; then
    log_error "Workspace not found."
    exit 1
fi

log_success "Workspace located."
log_info "Project Root: ${PROJECT_ROOT}"

###############################################################################
# Required Directories
###############################################################################

log_section "Required Directories"

DIRECTORIES=(
    ".cache"
    ".logs"
    ".tmp"

    "resources/backups"

    "tests/fixtures"

    "services/backend/media"

    "services/backend/static"

    "services/frontend/public"

    "services/ai/tests"

    "services/worker/tasks"
)

for directory in "${DIRECTORIES[@]}"; do

    ensure_directory "${PROJECT_ROOT}/${directory}"

done

log_success "Workspace directories verified."

###############################################################################
# Required Files
###############################################################################

log_section "Repository Files"

FILES=(
    ".env"
    ".env.example"
    ".gitignore"
    "README.md"
    "LICENSE"
    "compose.yaml"
)

for file in "${FILES[@]}"; do

    if file_exists "${PROJECT_ROOT}/${file}"; then
        log_pass "${file}"
    else
        log_warning "${file} is missing."
    fi

done

###############################################################################
# Git Repository
###############################################################################

log_section "Git Repository"

cd "${PROJECT_ROOT}"

if git rev-parse --git-dir >/dev/null 2>&1; then

    log_success "Git repository initialized."

else

    log_warning "Git repository not initialized."

fi

###############################################################################
# Python Workspace
###############################################################################

log_section "Python"

if file_exists "${PROJECT_ROOT}/pyproject.toml"; then

    log_success "pyproject.toml found."

else

    log_warning "pyproject.toml not found."

fi

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Workspace initialization completed successfully."

exit 0
