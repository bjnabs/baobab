#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : directories.sh
# Purpose     : Creates and verifies the BAOBAB workspace directory structure.
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

log_header "Workspace Directory Structure"

PROJECT_ROOT="$(get_project_root)"

###############################################################################
# Directory Structure
###############################################################################

log_section "Creating Directory Structure"

DIRECTORIES=(

    # -------------------------------------------------------------------------
    # Root
    # -------------------------------------------------------------------------

    ".cache"
    ".logs"
    ".tmp"

    # -------------------------------------------------------------------------
    # Resources
    # -------------------------------------------------------------------------

    "resources/backups"
    "resources/sample-data"
    "resources/seeds"
    "resources/templates"

    # -------------------------------------------------------------------------
    # Backend
    # -------------------------------------------------------------------------

    "services/backend/media"
    "services/backend/static"
    "services/backend/logs"

    # -------------------------------------------------------------------------
    # Frontend
    # -------------------------------------------------------------------------

    "services/frontend/public"
    "services/frontend/tests"

    # -------------------------------------------------------------------------
    # Mobile
    # -------------------------------------------------------------------------

    "services/mobile/test"

    # -------------------------------------------------------------------------
    # AI
    # -------------------------------------------------------------------------

    "services/ai/tests"

    # -------------------------------------------------------------------------
    # Worker
    # -------------------------------------------------------------------------

    "services/worker/tasks"
    "services/worker/schedules"
    "services/worker/monitoring"

    # -------------------------------------------------------------------------
    # Shared
    # -------------------------------------------------------------------------

    "shared/documentation"

    # -------------------------------------------------------------------------
    # Tests
    # -------------------------------------------------------------------------

    "tests/fixtures"
    "tests/unit"
    "tests/integration"
    "tests/api"
    "tests/security"
)

for directory in "${DIRECTORIES[@]}"; do

    ensure_directory "${PROJECT_ROOT}/${directory}"

done

###############################################################################
# Directory Report
###############################################################################

log_section "Workspace"

DIRECTORY_COUNT="${#DIRECTORIES[@]}"

log_info "Directories managed : ${DIRECTORY_COUNT}"

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Workspace directory structure verified."

exit 0

