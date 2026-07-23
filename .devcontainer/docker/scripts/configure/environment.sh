#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : environment.sh
# Purpose     : Configures the development environment variables required by
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

log_header "Environment Configuration"

###############################################################################
# Determine Project Root
###############################################################################

PROJECT_ROOT="$(get_project_root)"

if [[ -z "${PROJECT_ROOT}" ]]; then

    log_error "Unable to determine the BAOBAB project root."
    exit 1

fi

if [[ ! -d "${PROJECT_ROOT}" ]]; then

    log_error "Invalid project root: ${PROJECT_ROOT}"
    exit 1

fi

log_info "Project Root : ${PROJECT_ROOT}"

###############################################################################
# Project Environment
###############################################################################

log_section "Project Environment"

ENVIRONMENT_FILE="${PROJECT_ROOT}/.env"

if [[ ! -f "${ENVIRONMENT_FILE}" ]]; then

    if [[ -f "${PROJECT_ROOT}/.env.example" ]]; then

        cp "${PROJECT_ROOT}/.env.example" "${ENVIRONMENT_FILE}"

        log_success ".env created from .env.example"

    else

        log_warning ".env.example not found."

    fi

else

    log_info ".env already exists."

fi

###############################################################################
# Local Binary Path
###############################################################################

log_section "Local Binary Path"

LOCAL_BIN='export PATH="$HOME/.local/bin:$PATH"'

if ! grep -Fxq "${LOCAL_BIN}" "${HOME}/.bashrc"; then

    printf '\n# BAOBAB Local Tools\n%s\n' "${LOCAL_BIN}" >> "${HOME}/.bashrc"

    log_success "Added ~/.local/bin to PATH."

else

    log_info "PATH already configured."

fi

###############################################################################
# BAOBAB Environment Variables
###############################################################################

log_section "BAOBAB Variables"

#
# Export immediately for the current provisioning process.
#

export PROJECT_ROOT
export BAOBAB_HOME="${PROJECT_ROOT}"
export BAOBAB_ENV="development"

declare -A VARIABLES=(
    ["PROJECT_ROOT"]="${PROJECT_ROOT}"
    ["BAOBAB_HOME"]="${BAOBAB_HOME}"
    ["BAOBAB_ENV"]="${BAOBAB_ENV}"
)

for VARIABLE in "${!VARIABLES[@]}"; do

    VALUE="${VARIABLES[$VARIABLE]}"

    if grep -q "^export ${VARIABLE}=" "${HOME}/.bashrc"; then

        log_info "${VARIABLE} already configured."

    else

        printf 'export %s="%s"\n' "${VARIABLE}" "${VALUE}" >> "${HOME}/.bashrc"

        log_success "${VARIABLE} configured."

    fi

done

###############################################################################
# Reload Environment
###############################################################################

log_section "Reload Environment"

# shellcheck disable=SC1090
source "${HOME}/.bashrc"

log_success "Shell environment reloaded."

###############################################################################
# Summary
###############################################################################

log_section "Environment Summary"

log_info "PROJECT_ROOT : ${PROJECT_ROOT}"
log_info "BAOBAB_HOME : ${BAOBAB_HOME}"
log_info "BAOBAB_ENV  : ${BAOBAB_ENV}"

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Environment configuration completed successfully."

exit 0
