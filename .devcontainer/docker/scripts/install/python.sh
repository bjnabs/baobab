#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : python.sh
# Purpose     : Installs and configures the Python development environment for
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

log_header "Python Installation"

###############################################################################
# Verify Python
###############################################################################

log_section "Python"

if command_exists python3; then
    log_info "Python is already installed."
    log_info "$(python3 --version)"
else
    log_info "Installing Python..."

    sudo apt-get update

    sudo apt-get install -y \
        python3 \
        python3-dev \
        python3-pip \
        python3-venv \
        python3-full

    log_success "Python installed."
fi

###############################################################################
# Install uv
###############################################################################

log_section "uv"

if command_exists uv; then

    log_info "uv is already installed."
    log_info "$(uv --version)"

else

    log_info "Installing uv..."

    curl -LsSf https://astral.sh/uv/install.sh | sh

    export PATH="$HOME/.local/bin:$PATH"

    if ! grep -q 'HOME/.local/bin' "$HOME/.bashrc"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi

    log_success "uv installed."

fi

###############################################################################
# Upgrade pip
###############################################################################

log_section "pip"

python3 -m pip install --upgrade pip

log_success "pip upgraded."

###############################################################################
# Configure uv
###############################################################################

log_section "Python Workspace"

PROJECT_ROOT="$(get_project_root)"

cd "${PROJECT_ROOT}"

if [[ ! -f "pyproject.toml" ]]; then
    log_info "Initializing uv workspace..."
    uv init --bare
    log_success "uv workspace initialized."
else
    log_info "Existing pyproject.toml found."
fi

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Python environment configured successfully."

exit 0
