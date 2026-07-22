#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : database.sh
# Purpose     : Installs and configures the database client tools required by
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

log_header "Database Tool Installation"

###############################################################################
# PostgreSQL Client
###############################################################################

log_section "PostgreSQL Client"

if command_exists psql; then

    log_info "PostgreSQL client is already installed."
    log_info "$(psql --version)"

else

    log_info "Installing PostgreSQL client..."

    sudo apt-get update

    sudo apt-get install -y \
        postgresql-client

    log_success "PostgreSQL client installed."

fi

###############################################################################
# Redis CLI
###############################################################################

log_section "Redis CLI"

if command_exists redis-cli; then

    log_info "Redis CLI is already installed."
    log_info "$(redis-cli --version)"

else

    log_info "Installing Redis tools..."

    sudo apt-get install -y \
        redis-tools

    log_success "Redis CLI installed."

fi

###############################################################################
# PostgreSQL Connectivity
###############################################################################

log_section "PostgreSQL Connectivity"

PROJECT_ROOT="$(get_project_root)"
COMPOSE_FILE="${PROJECT_ROOT}/compose.yaml"

if file_exists "${COMPOSE_FILE}"; then

    cd "${PROJECT_ROOT}"

    if docker compose ps db >/dev/null 2>&1; then

        log_info "Database service 'db' detected."

        if docker compose exec -T db pg_isready >/dev/null 2>&1; then
            log_success "PostgreSQL server is accepting connections."
        else
            log_warning "PostgreSQL container exists but is not yet ready."
        fi

    else

        log_warning "Database container is not running."

    fi

else

    log_warning "compose.yaml not found. Skipping database connectivity checks."

fi

###############################################################################
# Redis Connectivity
###############################################################################

log_section "Redis Connectivity"

if file_exists "${COMPOSE_FILE}"; then

    cd "${PROJECT_ROOT}"

    if docker compose ps redis >/dev/null 2>&1; then

        log_info "Redis service detected."

        if docker compose exec -T redis redis-cli ping >/dev/null 2>&1; then
            log_success "Redis server is responding."
        else
            log_warning "Redis container exists but is not yet ready."
        fi

    else

        log_warning "Redis container is not running."

    fi

fi

###############################################################################
# Database Environment
###############################################################################

log_section "Database Environment"

if [[ -f "${PROJECT_ROOT}/.env" ]]; then

    log_info "Project environment file detected."

else

    log_warning ".env file not found."

fi

###############################################################################
# Summary
###############################################################################

log_blank

log_info "Installed Database Tools"

command_exists psql && log_info "  • PostgreSQL : $(psql --version)"
command_exists redis-cli && log_info "  • Redis CLI : $(redis-cli --version)"

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Database environment configured successfully."

exit 0
