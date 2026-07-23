#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : docker.sh
# Purpose     : Verifies and configures the Docker development tooling required
#               by the BAOBAB Development Environment.
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

log_header "Docker Installation"

###############################################################################
# Docker CLI
###############################################################################

log_section "Docker CLI"

if command_exists docker; then

    log_info "Docker CLI is available."
    log_info "$(docker --version)"

else

    log_error "Docker CLI is not installed."
    exit 1

fi

###############################################################################
# Docker Compose
###############################################################################

log_section "Docker Compose"

if docker compose version >/dev/null 2>&1; then

    log_info "$(docker compose version)"

else

    log_error "Docker Compose is not available."
    exit 1

fi

###############################################################################
# Docker Buildx
###############################################################################

log_section "Docker Buildx"

if docker buildx version >/dev/null 2>&1; then

    log_info "$(docker buildx version | head -n 1)"

else

    log_warning "Docker Buildx is not available."

fi

###############################################################################
# Docker Context
###############################################################################

log_section "Docker Context"

CURRENT_CONTEXT="$(docker context show)"

log_info "Current Context: ${CURRENT_CONTEXT}"

###############################################################################
# Docker Engine
###############################################################################

log_section "Docker Engine"

if docker info >/dev/null 2>&1; then

    log_success "Docker Engine is accessible."

else

    log_warning "Docker Engine is not currently running or is unavailable."

fi

###############################################################################
# BAOBAB Compose File
###############################################################################

log_section "Compose Configuration"

PROJECT_ROOT="$(get_project_root)"
COMPOSE_FILE="${PROJECT_ROOT}/compose.yaml"

if file_exists "${COMPOSE_FILE}"; then

    cd "${PROJECT_ROOT}"

    docker compose config >/dev/null

    log_success "compose.yaml validation successful."

else

    log_warning "compose.yaml not found."

fi

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Docker environment verification completed."

exit 0
