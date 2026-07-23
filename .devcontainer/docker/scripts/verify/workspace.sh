#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : workspace.sh
# Purpose     : Verifies the BAOBAB workspace structure and repository health.
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

log_header "Workspace Verification"

PROJECT_ROOT="$(get_project_root)"

FAILED=0

###############################################################################
# Repository Root
###############################################################################

log_section "Repository"

ROOT_FILES=(
    ".gitignore"
    ".editorconfig"
    ".env.example"
    "README.md"
    "LICENSE"
    "compose.yaml"
)

for file in "${ROOT_FILES[@]}"; do

    if file_exists "${PROJECT_ROOT}/${file}"; then

        log_pass "${file}"

    else

        log_fail "${file}"
        FAILED=1

    fi

done

###############################################################################
# Project Directories
###############################################################################

log_section "Project Structure"

DIRECTORIES=(
    ".devcontainer"
    ".github"

    "docs"

    "services"

    "packages"

    "shared"

    "resources"

    "tests"

    "infrastructure"
)

for directory in "${DIRECTORIES[@]}"; do

    if directory_exists "${PROJECT_ROOT}/${directory}"; then

        log_pass "${directory}"

    else

        log_fail "${directory}"
        FAILED=1

    fi

done

###############################################################################
# Service Directories
###############################################################################

log_section "Services"

SERVICES=(
    "backend"
    "frontend"
    "mobile"
    "ai"
    "worker"
)

for service in "${SERVICES[@]}"; do

    if directory_exists "${PROJECT_ROOT}/services/${service}"; then

        log_pass "${service}"

    else

        log_warning "${service} not initialized."

    fi

done

###############################################################################
# Environment Files
###############################################################################

log_section "Environment"

ENVIRONMENT_ROOT="${PROJECT_ROOT}/resources/environments"

if directory_exists "${ENVIRONMENT_ROOT}"; then

    log_pass "resources/environments"

    ENVIRONMENTS=(
        development
        testing
        staging
        production
    )

    for env in "${ENVIRONMENTS[@]}"; do

        if directory_exists "${ENVIRONMENT_ROOT}/${env}"; then

            log_pass "${env}"

        else

            log_warning "${env}"

        fi

    done

else

    log_warning "resources/environments not found."

fi

###############################################################################
# Git Repository
###############################################################################

log_section "Git"

cd "${PROJECT_ROOT}"

if git rev-parse --git-dir >/dev/null 2>&1; then

    log_pass "Git repository"

    BRANCH="$(git branch --show-current)"

    log_info "Branch : ${BRANCH}"

    if git diff --quiet; then

        log_pass "Working tree clean"

    else

        log_warning "Working tree contains changes."

    fi

else

    log_fail "Git repository"
    FAILED=1

fi

###############################################################################
# Workspace Statistics
###############################################################################

log_section "Workspace Statistics"

FILE_COUNT="$(find "${PROJECT_ROOT}" -type f | wc -l | tr -d ' ')"

DIRECTORY_COUNT="$(find "${PROJECT_ROOT}" -type d | wc -l | tr -d ' ')"

log_info "Files       : ${FILE_COUNT}"
log_info "Directories : ${DIRECTORY_COUNT}"

###############################################################################
# Summary
###############################################################################

if [[ "${FAILED}" -eq 0 ]]; then

    log_blank
    log_success "Workspace verification completed successfully."

else

    log_blank
    log_error "Workspace verification failed."

    exit 1

fi

exit 0
