#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : docker.sh
# Purpose     : Verifies the Docker development environment.
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

log_header "Docker Verification"

PROJECT_ROOT="$(get_project_root)"

FAILED=0

###############################################################################
# Docker CLI
###############################################################################

log_section "Docker CLI"

if command_exists docker; then

    log_pass "Docker"
    log_info "$(docker --version)"

else

    log_fail "Docker"
    FAILED=1

fi

###############################################################################
# Docker Compose
###############################################################################

log_section "Docker Compose"

if docker compose version >/dev/null 2>&1; then

    log_pass "Docker Compose"
    log_info "$(docker compose version)"

else

    log_fail "Docker Compose"
    FAILED=1

fi

###############################################################################
# Docker Buildx
###############################################################################

log_section "Docker Buildx"

if docker buildx version >/dev/null 2>&1; then

    log_pass "Buildx"
    log_info "$(docker buildx version | head -n 1)"

else

    log_warning "Docker Buildx not available."

fi

###############################################################################
# Docker Engine
###############################################################################

log_section "Docker Engine"

if docker info >/dev/null 2>&1; then

    log_pass "Docker Engine"

else

    log_fail "Docker Engine"
    FAILED=1

fi

###############################################################################
# Docker Context
###############################################################################

log_section "Docker Context"

CURRENT_CONTEXT="$(docker context show)"

log_info "Current Context : ${CURRENT_CONTEXT}"

###############################################################################
# Docker Compose Configuration
###############################################################################

log_section "compose.yaml"

COMPOSE_FILE="${PROJECT_ROOT}/compose.yaml"

if file_exists "${COMPOSE_FILE}"; then

    cd "${PROJECT_ROOT}"

    if docker compose config >/dev/null 2>&1; then

        log_pass "compose.yaml"

    else

        log_fail "compose.yaml"

        FAILED=1

    fi

else

    log_fail "compose.yaml"

    FAILED=1

fi

###############################################################################
# Running Services
###############################################################################

log_section "Containers"

if docker compose ps >/dev/null 2>&1; then

    docker compose ps

else

    log_warning "No running compose project."

fi

###############################################################################
# Docker Images
###############################################################################

log_section "Images"

docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" || true

###############################################################################
# Docker Networks
###############################################################################

log_section "Networks"

docker network ls || true

###############################################################################
# Summary
###############################################################################

if [[ "${FAILED}" -eq 0 ]]; then

    log_blank
    log_success "Docker verification completed successfully."

else

    log_blank
    log_error "Docker verification failed."

    exit 1

fi

exit 0
