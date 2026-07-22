#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : checks.sh
# Purpose     : Provides reusable validation and verification functions for the
#               BAOBAB Development Environment Provisioning Framework.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
#
# Notes
# -----
# This script contains reusable validation functions only.
# It performs no installation or configuration.
# ==============================================================================
#
# shellcheck disable=SC1091

# Prevent multiple sourcing
[[ -n "${BAOBAB_CHECKS_LOADED:-}" ]] && return
readonly BAOBAB_CHECKS_LOADED=1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load dependencies
source "${SCRIPT_DIR}/colors.sh"
source "${SCRIPT_DIR}/functions.sh"
source "${SCRIPT_DIR}/logging.sh"

###############################################################################
# Commands
###############################################################################

check_command() {
    local command="$1"
    local version_command="${2:-}"

    if command_exists "${command}"; then
        if [[ -n "${version_command}" ]]; then
            local version
            version=$(eval "${version_command}" 2>/dev/null | head -n 1)
            log_pass "${command} (${version})"
        else
            log_pass "${command}"
        fi
        return 0
    fi

    log_fail "${command}"
    return 1
}

###############################################################################
# Files
###############################################################################

check_file() {
    local file="$1"

    if file_exists "${file}"; then
        log_pass "${file}"
        return 0
    fi

    log_fail "${file}"
    return 1
}

###############################################################################
# Directories
###############################################################################

check_directory() {
    local directory="$1"

    if directory_exists "${directory}"; then
        log_pass "${directory}"
        return 0
    fi

    log_fail "${directory}"
    return 1
}

###############################################################################
# Environment Variables
###############################################################################

check_environment_variable() {
    local variable="$1"

    if [[ -n "${!variable:-}" ]]; then
        log_pass "${variable}"
        return 0
    fi

    log_fail "${variable}"
    return 1
}

###############################################################################
# Ports
###############################################################################

check_port() {
    local port="$1"

    if command_exists ss; then
        if ss -ltn | awk '{print $4}' | grep -q ":${port}$"; then
            log_pass "Port ${port}"
            return 0
        fi
    elif command_exists netstat; then
        if netstat -ltn 2>/dev/null | awk '{print $4}' | grep -q ":${port}$"; then
            log_pass "Port ${port}"
            return 0
        fi
    fi

    log_fail "Port ${port}"
    return 1
}

###############################################################################
# Docker
###############################################################################

check_container() {
    local container="$1"

    if command_exists docker &&
       docker ps --format '{{.Names}}' | grep -Fxq "${container}"; then
        log_pass "Container ${container}"
        return 0
    fi

    log_fail "Container ${container}"
    return 1
}

check_network() {
    local network="$1"

    if command_exists docker &&
       docker network ls --format '{{.Name}}' | grep -Fxq "${network}"; then
        log_pass "Network ${network}"
        return 0
    fi

    log_fail "Network ${network}"
    return 1
}

###############################################################################
# Summary Counters
###############################################################################

BAOBAB_CHECKS_PASSED=0
BAOBAB_CHECKS_FAILED=0

record_check_result() {
    local status="$1"

    if [[ "${status}" -eq 0 ]]; then
        ((BAOBAB_CHECKS_PASSED++))
    else
        ((BAOBAB_CHECKS_FAILED++))
    fi
}

print_check_summary() {
    log_blank
    log_section "Verification Summary"

    printf "Passed : %d\n" "${BAOBAB_CHECKS_PASSED}"
    printf "Failed : %d\n" "${BAOBAB_CHECKS_FAILED}"

    log_blank

    if [[ "${BAOBAB_CHECKS_FAILED}" -eq 0 ]]; then
        log_success "All verification checks passed."
        return 0
    fi

    log_error "One or more verification checks failed."
    return 1
}
