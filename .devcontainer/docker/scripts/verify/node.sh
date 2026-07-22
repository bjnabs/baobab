#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : node.sh
# Purpose     : Verifies the Node.js development environment.
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

log_header "Node.js Verification"

PROJECT_ROOT="$(get_project_root)"

FAILED=0
FRONTEND_DIR="${PROJECT_ROOT}/services/frontend"

###############################################################################
# Node.js
###############################################################################

log_section "Node.js"

if command_exists node; then
    log_pass "Node.js"
    log_info "$(node --version)"
else
    log_fail "Node.js"
    FAILED=1
fi

###############################################################################
# npm
###############################################################################

log_section "npm"

if command_exists npm; then
    log_pass "npm"
    log_info "$(npm --version)"
else
    log_fail "npm"
    FAILED=1
fi

###############################################################################
# Corepack
###############################################################################

log_section "Corepack"

if command_exists corepack; then
    log_pass "Corepack"
    log_info "$(corepack --version)"
else
    log_warning "Corepack not installed."
fi

###############################################################################
# Frontend Project
###############################################################################

log_section "Frontend Project"

if directory_exists "${FRONTEND_DIR}"; then

    log_pass "services/frontend"

    if file_exists "${FRONTEND_DIR}/package.json"; then
        log_pass "package.json"
    else
        log_warning "package.json not found."
    fi

    if file_exists "${FRONTEND_DIR}/package-lock.json"; then
        log_pass "package-lock.json"
    else
        log_info "package-lock.json not found."
    fi

    if directory_exists "${FRONTEND_DIR}/node_modules"; then
        log_pass "node_modules"
    else
        log_warning "Dependencies have not been installed."
    fi

else

    log_warning "Frontend project has not been initialized."

fi

###############################################################################
# TypeScript
###############################################################################

log_section "TypeScript"

if [[ -x "${FRONTEND_DIR}/node_modules/.bin/tsc" ]]; then

    log_pass "TypeScript"
    log_info "$("${FRONTEND_DIR}/node_modules/.bin/tsc" --version)"

else

    log_warning "TypeScript compiler not available."

fi

###############################################################################
# Summary
###############################################################################

if [[ "${FAILED}" -eq 0 ]]; then
    log_blank
    log_success "Node.js verification completed successfully."
else
    log_blank
    log_error "Node.js verification failed."
    exit 1
fi

exit 0
