#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : python.sh
# Purpose     : Verifies the Python development environment.
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
source "${SCRIPT_DIR}/../utils/checks.sh"

log_header "Python Verification"

PROJECT_ROOT="$(get_project_root)"

FAILED=0

###############################################################################
# Python
###############################################################################

log_section "Python"

if command_exists python3; then
    log_pass "Python3"
    log_info "$(python3 --version)"
else
    log_fail "Python3"
    FAILED=1
fi

###############################################################################
# pip
###############################################################################

log_section "pip"

if command_exists pip3; then
    log_pass "pip3"
    log_info "$(pip3 --version)"
else
    log_fail "pip3"
    FAILED=1
fi

###############################################################################
# uv
###############################################################################

log_section "uv"

if command_exists uv; then
    log_pass "uv"
    log_info "$(uv --version)"
else
    log_fail "uv"
    FAILED=1
fi

###############################################################################
# Virtual Environment
###############################################################################

log_section "Virtual Environment"

if [[ -d "${PROJECT_ROOT}/.venv" ]]; then
    log_pass ".venv"
else
    log_warning ".venv has not been created yet."
fi

###############################################################################
# Project Configuration
###############################################################################

log_section "Project Configuration"

if file_exists "${PROJECT_ROOT}/pyproject.toml"; then
    log_pass "pyproject.toml"
else
    log_warning "pyproject.toml not found."
fi

if file_exists "${PROJECT_ROOT}/uv.lock"; then
    log_pass "uv.lock"
else
    log_warning "uv.lock not found."
fi

###############################################################################
# Python Services
###############################################################################

log_section "Python Services"

SERVICES=(
    "services/backend"
    "services/ai"
    "services/worker"
)

for service in "${SERVICES[@]}"; do

    if directory_exists "${PROJECT_ROOT}/${service}"; then

        log_info "${service}"

        if file_exists "${PROJECT_ROOT}/${service}/pyproject.toml"; then
            log_pass "pyproject.toml"
        else
            log_warning "No pyproject.toml"
        fi

    else

        log_warning "${service} not yet initialized."

    fi

done

###############################################################################
# Summary
###############################################################################

if [[ "${FAILED}" -eq 0 ]]; then
    log_blank
    log_success "Python verification completed successfully."
else
    log_blank
    log_error "Python verification failed."
    exit 1
fi

exit 0
