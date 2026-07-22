#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : summary.sh
# Purpose     : Displays a summary of the BAOBAB Development Environment after
#               provisioning and verification.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
#
# Notes
# -----
# This script reports the current state of the development environment.
# It performs no installation or configuration.
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ------------------------------------------------------------------------------
# Load Utilities
# ------------------------------------------------------------------------------

# shellcheck source=/dev/null
source "${SCRIPT_DIR}/utils/colors.sh"
source "${SCRIPT_DIR}/utils/functions.sh"
source "${SCRIPT_DIR}/utils/logging.sh"

###############################################################################
# Summary
###############################################################################

log_header "BAOBAB Development Environment Summary"

###############################################################################
# Environment
###############################################################################

log_section "Environment"

log_info "Operating System : $(uname -s)"
log_info "Architecture     : $(uname -m)"
log_info "User             : $(whoami)"
log_info "Project Root     : $(get_project_root)"

###############################################################################
# Language Runtimes
###############################################################################

log_section "Language Runtimes"

if command_exists python3; then
    log_pass "$(python3 --version)"
else
    log_fail "Python 3"
fi

if command_exists uv; then
    log_pass "$(uv --version)"
else
    log_fail "uv"
fi

if command_exists node; then
    log_pass "$(node --version)"
else
    log_fail "Node.js"
fi

if command_exists npm; then
    log_pass "npm $(npm --version)"
else
    log_fail "npm"
fi

if command_exists java; then
    log_pass "$(java --version | head -n 1)"
else
    log_fail "Java"
fi

if command_exists flutter; then
    log_pass "$(flutter --version | head -n 1)"
else
    log_fail "Flutter"
fi

###############################################################################
# Developer Tools
###############################################################################

log_section "Developer Tools"

if command_exists git; then
    log_pass "$(git --version)"
else
    log_fail "Git"
fi

if command_exists docker; then
    log_pass "$(docker --version)"
else
    log_fail "Docker"
fi

if command_exists gh; then
    log_pass "$(gh --version | head -n 1)"
else
    log_fail "GitHub CLI"
fi

###############################################################################
# Workspace
###############################################################################

log_section "Workspace"

check_directory "$(get_project_root)"
check_file "$(get_project_root)/pyproject.toml"
check_file "$(get_project_root)/compose.yaml"

###############################################################################
# Completion
###############################################################################

log_blank
log_success "Development environment summary completed."

exit 0
