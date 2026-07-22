#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : node.sh
# Purpose     : Installs and configures the Node.js development environment for
#               the BAOBAB Development Environment.
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

log_header "Node.js Installation"

###############################################################################
# Verify Node.js
###############################################################################

log_section "Node.js"

if command_exists node; then

    log_info "Node.js is already installed."
    log_info "$(node --version)"

else

    log_info "Installing Node.js..."

    sudo apt-get update

    sudo apt-get install -y \
        nodejs \
        npm

    log_success "Node.js installed."

fi

###############################################################################
# Verify npm
###############################################################################

log_section "npm"

if command_exists npm; then

    log_info "npm is available."
    log_info "Version: $(npm --version)"

else

    log_error "npm installation failed."
    exit 1

fi

###############################################################################
# Enable Corepack
###############################################################################

log_section "Corepack"

if command_exists corepack; then

    corepack enable

    log_success "Corepack enabled."

else

    log_warning "Corepack is not available."

fi

###############################################################################
# Install Project Dependencies
###############################################################################

log_section "Frontend Dependencies"

PROJECT_ROOT="$(get_project_root)"
FRONTEND_DIR="${PROJECT_ROOT}/services/frontend"

if directory_exists "${FRONTEND_DIR}" && file_exists "${FRONTEND_DIR}/package.json"; then

    cd "${FRONTEND_DIR}"

    npm install

    log_success "Frontend dependencies installed."

else

    log_warning "Frontend project not initialized. Skipping dependency installation."

fi

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Node.js environment configured successfully."

exit 0
