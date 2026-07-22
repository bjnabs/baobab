#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : system.sh
# Purpose     : Verifies the operating system and core development tools.
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

log_header "System Verification"

###############################################################################
# Operating System
###############################################################################

log_section "Operating System"

log_info "Kernel       : $(uname -s)"
log_info "Release      : $(uname -r)"
log_info "Architecture : $(uname -m)"

###############################################################################
# Required Commands
###############################################################################

log_section "Core Tools"

TOOLS=(
    bash
    curl
    wget
    git
    jq
    tree
    unzip
    zip
)

FAILED=0

for tool in "${TOOLS[@]}"; do

    if command_exists "${tool}"; then
        log_pass "${tool}"
    else
        log_fail "${tool}"
        FAILED=1
    fi

done

###############################################################################
# Available Disk Space
###############################################################################

log_section "Disk Space"

df -h .

###############################################################################
# Memory
###############################################################################

log_section "Memory"

free -h || true

###############################################################################
# Complete
###############################################################################

if [[ "${FAILED}" -eq 0 ]]; then
    log_blank
    log_success "System verification passed."
else
    log_blank
    log_error "System verification failed."
    exit 1
fi

exit 0
