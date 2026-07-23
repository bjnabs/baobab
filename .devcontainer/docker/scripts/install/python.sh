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
source "${SCRIPT_DIR}/../config/versions.sh"

log_header "Python Installation"

###############################################################################
# Refresh Package Index
###############################################################################

sudo apt-get update

###############################################################################
# Configuration
###############################################################################

PYTHON_BIN="python3"

PYTHON_PACKAGE="python${PYTHON_VERSION}-full"
PYTHON_DEV_PACKAGE="python${PYTHON_VERSION}-dev"
PYTHON_VENV_PACKAGE="python${PYTHON_VERSION}-venv"

UV_HOME="${HOME}/.local/bin"

export PATH="${UV_HOME}:${PATH}"

###############################################################################
# Python
###############################################################################

log_section "Python"

if ! command_exists "${PYTHON_BIN}"; then

    log_info "Python not found."
    log_info "Installing Python ${PYTHON_VERSION}..."

    sudo apt-get install -y \
        "${PYTHON_PACKAGE}" \
        "${PYTHON_DEV_PACKAGE}"

fi

CURRENT_VERSION="$(
${PYTHON_BIN} -c '
import sys
print(f"{sys.version_info.major}.{sys.version_info.minor}")
'
)"

log_info "Target Python : ${PYTHON_VERSION}"
log_info "Detected      : ${CURRENT_VERSION}"

if [[ "${CURRENT_VERSION}" != "${PYTHON_VERSION}" ]]; then

    log_warning "Expected Python ${PYTHON_VERSION}."
    log_warning "Detected Python ${CURRENT_VERSION}."

    sudo apt-get install -y \
        "${PYTHON_PACKAGE}" \
        "${PYTHON_DEV_PACKAGE}"

fi

###############################################################################
# pip
###############################################################################

log_section "pip"

if ! ${PYTHON_BIN} -m ensurepip --version >/dev/null 2>&1; then

    log_info "Bootstrapping pip..."

    sudo apt-get install -y "${PYTHON_PACKAGE}"

fi

if ${PYTHON_BIN} -m pip --version >/dev/null 2>&1; then

    log_info "$(${PYTHON_BIN} -m pip --version)"

else

    log_error "pip installation failed."
    exit 1

fi

###############################################################################
# venv
###############################################################################

log_section "venv"

if ${PYTHON_BIN} -m venv --help >/dev/null 2>&1; then

    log_info "venv support detected."

else

    log_info "Installing ${PYTHON_VENV_PACKAGE}..."

    sudo apt-get install -y "${PYTHON_VENV_PACKAGE}"

fi

###############################################################################
# Development Headers
###############################################################################

log_section "Development Headers"

if dpkg -s "${PYTHON_DEV_PACKAGE}" >/dev/null 2>&1; then

    log_info "${PYTHON_DEV_PACKAGE} already installed."

else

    log_info "Installing ${PYTHON_DEV_PACKAGE}..."

    sudo apt-get install -y "${PYTHON_DEV_PACKAGE}"

fi

###############################################################################
# Upgrade Python Toolchain
###############################################################################

log_section "Python Toolchain"

${PYTHON_BIN} -m pip install --upgrade \
    pip \
    setuptools \
    wheel

log_success "Python toolchain upgraded."

###############################################################################
# uv
###############################################################################

log_section "uv"

if command_exists uv; then

    log_info "uv already installed."
    log_info "$(uv --version)"

else

    log_info "Installing uv..."

    curl \
        --fail \
        --location \
        --silent \
        --show-error \
        https://astral.sh/uv/install.sh | sh

    if ! grep -q 'HOME/.local/bin' "${HOME}/.bashrc"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "${HOME}/.bashrc"
    fi

    export PATH="${UV_HOME}:${PATH}"

    log_success "uv installed."

fi

###############################################################################
# Python Workspace
###############################################################################

log_section "Python Workspace"

PROJECT_ROOT="$(get_project_root)"

cd "${PROJECT_ROOT}"

if [[ ! -f pyproject.toml ]]; then

    log_info "Initializing uv workspace..."

    uv init \
        --bare \
        --python "${PYTHON_BIN}"

    log_success "uv workspace initialized."

else

    log_info "Existing pyproject.toml found."

fi

log_info "uv interpreter:"
uv python find

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Python ${CURRENT_VERSION} environment configured successfully."

exit 0
