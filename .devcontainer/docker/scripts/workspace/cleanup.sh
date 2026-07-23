#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : cleanup.sh
# Purpose     : Cleans temporary files, caches, and provisioning artifacts from
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

log_header "Workspace Cleanup"

PROJECT_ROOT="$(get_project_root)"

###############################################################################
# Remove Temporary Workspace Files
###############################################################################

log_section "Workspace"

TEMP_DIRECTORIES=(
    ".cache"
    ".logs"
    ".tmp"
)

for directory in "${TEMP_DIRECTORIES[@]}"; do

    TARGET="${PROJECT_ROOT}/${directory}"

    if [[ -d "${TARGET}" ]]; then
        rm -rf "${TARGET:?}/"*
        log_success "Cleaned ${directory}"
    else
        log_info "${directory} not found."
    fi

done

###############################################################################
# Python
###############################################################################

log_section "Python"

find "${PROJECT_ROOT}" \
    -type d \
    -name "__pycache__" \
    -prune \
    -exec rm -rf {} +

find "${PROJECT_ROOT}" \
    -type f \
    -name "*.pyc" \
    -delete

find "${PROJECT_ROOT}" \
    -type f \
    -name "*.pyo" \
    -delete

find "${PROJECT_ROOT}" \
    -type f \
    -name "*.pyd" \
    -delete

log_success "Python cache cleaned."

###############################################################################
# Node.js
###############################################################################

log_section "Node.js"

find "${PROJECT_ROOT}" \
    -type d \
    -name ".next" \
    -prune \
    -exec rm -rf {} +

find "${PROJECT_ROOT}" \
    -type d \
    -name ".turbo" \
    -prune \
    -exec rm -rf {} +

log_success "Frontend cache cleaned."

###############################################################################
# Flutter
###############################################################################

log_section "Flutter"

MOBILE_DIR="${PROJECT_ROOT}/services/mobile"

if [[ -d "${MOBILE_DIR}" ]]; then

    (
        cd "${MOBILE_DIR}"

        if command -v flutter >/dev/null 2>&1; then
            flutter clean >/dev/null 2>&1 || true
        fi
    )

    log_success "Flutter build artifacts cleaned."

else

    log_info "Mobile project not initialized."

fi

###############################################################################
# Docker
###############################################################################

log_section "Docker"

if command -v docker >/dev/null 2>&1; then

    docker builder prune -f >/dev/null 2>&1 || true

    log_success "Docker builder cache cleaned."

else

    log_info "Docker not available."

fi

###############################################################################
# Summary
###############################################################################

log_blank
log_success "Workspace cleanup completed successfully."

exit 0
