#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : database.sh
# Purpose     : Verifies the BAOBAB data services.
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

log_header "Database Verification"

PROJECT_ROOT="$(get_project_root)"

FAILED=0

###############################################################################
# PostgreSQL Client
###############################################################################

log_section "PostgreSQL"

if command_exists psql; then

    log_pass "psql"
    log_info "$(psql --version)"

else

    log_warning "PostgreSQL client not installed."

fi

###############################################################################
# Redis Client
###############################################################################

log_section "Redis"

if command_exists redis-cli; then

    log_pass "redis-cli"
    log_info "$(redis-cli --version)"

else

    log_warning "Redis client not installed."

fi

###############################################################################
# Docker Compose Services
###############################################################################

log_section "Docker Services"

cd "${PROJECT_ROOT}"

if ! file_exists "compose.yaml"; then

    log_fail "compose.yaml not found."
    exit 1

fi

SERVICES=(
    db
    redis
    minio
)

for service in "${SERVICES[@]}"; do

    if docker compose ps --services | grep -qx "${service}"; then

        if [[ "$(docker compose ps -q "${service}")" != "" ]]; then

            STATUS="$(docker inspect \
                --format='{{.State.Status}}' \
                "$(docker compose ps -q "${service}")")"

            if [[ "${STATUS}" == "running" ]]; then

                log_pass "${service}"

            else

                log_warning "${service} (${STATUS})"

            fi

        else

            log_warning "${service} not created."

        fi

    else

        log_info "${service} not defined."

    fi

done

###############################################################################
# PostgreSQL Health
###############################################################################

log_section "PostgreSQL Health"

if docker compose ps --services | grep -qx "db"; then

    if docker compose exec -T db pg_isready >/dev/null 2>&1; then

        log_pass "PostgreSQL accepting connections."

    else

        log_warning "PostgreSQL not ready."

    fi

fi

###############################################################################
# Redis Health
###############################################################################

log_section "Redis Health"

if docker compose ps --services | grep -qx "redis"; then

    if docker compose exec -T redis redis-cli ping >/dev/null 2>&1; then

        log_pass "Redis responding."

    else

        log_warning "Redis not responding."

    fi

fi

###############################################################################
# MinIO Health
###############################################################################

log_section "MinIO"

if docker compose ps --services | grep -qx "minio"; then

    if docker compose exec -T minio sh -c "test -d /data" >/dev/null 2>&1; then

        log_pass "MinIO data volume."

    else

        log_warning "MinIO volume unavailable."

    fi

fi

###############################################################################
# Summary
###############################################################################

if [[ "${FAILED}" -eq 0 ]]; then

    log_blank
    log_success "Database verification completed successfully."

else

    log_blank
    log_error "Database verification failed."

    exit 1

fi

exit 0
