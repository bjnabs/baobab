#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : logging.sh
# Purpose     : Provides standardized logging functions for the BAOBAB
#               Development Environment Provisioning Framework.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
#
# Notes
# -----
# This script provides logging utilities only.
# ==============================================================================
#
# shellcheck disable=SC1091

# Prevent multiple sourcing
[[ -n "${BAOBAB_LOGGING_LOADED:-}" ]] && return
readonly BAOBAB_LOGGING_LOADED=1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load dependencies
source "${SCRIPT_DIR}/colors.sh"
source "${SCRIPT_DIR}/functions.sh"

###############################################################################
# Logging
###############################################################################

log() {
    local level="$1"
    local colour="$2"
    shift 2

    printf "%b[%s] [%s]%b %s\n" \
        "${colour}" \
        "$(timestamp)" \
        "${level}" \
        "${RESET}" \
        "$*"
}

###############################################################################
# Standard Messages
###############################################################################

log_info() {
    log "INFO" "${CYAN}" "$@"
}

log_success() {
    log "SUCCESS" "${GREEN}" "$@"
}

log_warning() {
    log "WARNING" "${YELLOW}" "$@"
}

log_error() {
    log "ERROR" "${RED}" "$@"
}

log_debug() {
    log "DEBUG" "${MAGENTA}" "$@"
}

###############################################################################
# Headings
###############################################################################

log_header() {
    echo
    printf "%b============================================================%b\n" "${BOLD}${BLUE}" "${RESET}"
    printf "%b%s%b\n" "${BOLD}${BLUE}" "$*" "${RESET}"
    printf "%b============================================================%b\n" "${BOLD}${BLUE}" "${RESET}"
    echo
}

log_section() {
    echo
    printf "%b---- %s ----%b\n" "${BOLD}${CYAN}" "$*" "${RESET}"
}

log_subsection() {
    printf "%b• %s%b\n" "${BOLD}" "$*" "${RESET}"
}

###############################################################################
# Status
###############################################################################

log_pass() {
    printf "%b✔%b %s\n" "${GREEN}" "${RESET}" "$*"
}

log_fail() {
    printf "%b✘%b %s\n" "${RED}" "${RESET}" "$*"
}

log_skip() {
    printf "%b➜%b %s\n" "${YELLOW}" "${RESET}" "$*"
}

###############################################################################
# Blank Line
###############################################################################

log_blank() {
    echo
}
