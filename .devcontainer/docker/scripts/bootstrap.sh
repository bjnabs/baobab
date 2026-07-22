#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : bootstrap.sh
# Purpose     : Prepares the development environment prior to provisioning.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
#
# Notes
# -----
# This script performs initial workspace preparation before the post-create
# process begins.
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load utilities
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/utils/colors.sh"
source "${SCRIPT_DIR}/utils/functions.sh"
source "${SCRIPT_DIR}/utils/logging.sh"

log_header "BAOBAB Bootstrap"

PROJECT_ROOT="$(get_project_root)"

log_info "Project root: ${PROJECT_ROOT}"

###############################################################################
# Workspace Preparation
###############################################################################

log_section "Preparing Workspace"

ensure_directory "${PROJECT_ROOT}/.cache"
ensure_directory "${PROJECT_ROOT}/.logs"
ensure_directory "${PROJECT_ROOT}/.tmp"

log_success "Workspace directories verified."

###############################################################################
# Script Permissions
###############################################################################

log_section "Setting Script Permissions"

find "${SCRIPT_DIR}" -type f -name "*.sh" -exec chmod +x {} \;

log_success "Script permissions verified."

###############################################################################
# Environment
###############################################################################

log_section "Environment"

log_info "Operating System : $(uname -s)"
log_info "Architecture     : $(uname -m)"
log_info "Current User     : $(whoami)"
log_info "Working Directory: ${PROJECT_ROOT}"

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Bootstrap completed successfully."
