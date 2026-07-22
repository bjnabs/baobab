#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : verify.sh
# Purpose     : Verifies the BAOBAB Development Environment.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
#
# Notes
# -----
# This script orchestrates all verification modules and produces the overall
# verification result.
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
source "${SCRIPT_DIR}/utils/checks.sh"

log_header "BAOBAB Environment Verification"

###############################################################################
# Verification Modules
###############################################################################

log_section "System"

bash "${SCRIPT_DIR}/verify/system.sh"

log_section "Python"

bash "${SCRIPT_DIR}/verify/python.sh"

log_section "Node.js"

bash "${SCRIPT_DIR}/verify/node.sh"

log_section "Flutter"

bash "${SCRIPT_DIR}/verify/flutter.sh"

log_section "Docker"

bash "${SCRIPT_DIR}/verify/docker.sh"

log_section "Database"

bash "${SCRIPT_DIR}/verify/database.sh"

###############################################################################
# Summary
###############################################################################

print_check_summary

###############################################################################
# Exit Status
###############################################################################

if [[ "${BAOBAB_CHECKS_FAILED}" -eq 0 ]]; then
    exit 0
fi

exit 1
