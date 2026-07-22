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

PROJECT_ROOT="$(get_project_root)"

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

    echo "" >> "${HOME}/.bashrc"
    echo "# BAOBAB Local Tools" >> "${HOME}/.bashrc"
    echo "${LOCAL_BIN}" >> "${HOME}/.bashrc"

    log_success "Added ~/.local/bin to PATH."

else

    log_info "PATH already configured."

fi

###############################################################################
# BAOBAB Environment Variables
###############################################################################

log_section "BAOBAB Variables"

declare -A VARIABLES=(
    ["BAOBAB_HOME"]="${PROJECT_ROOT}"
    ["BAOBAB_ENV"]="development"
)

for VARIABLE in "${!VARIABLES[@]}"; do

    VALUE="${VARIABLES[$VARIABLE]}"

    if ! grep -q "^export ${VARIABLE}=" "${HOME}/.bashrc"; then

        echo "export ${VARIABLE}=\"${VALUE}\"" >> "${HOME}/.bashrc"

        log_success "${VARIABLE} configured."

    else

        log_info "${VARIABLE} already configured."

    fi

done

###############################################################################
# Load Environment
###############################################################################

log_section "Reload Environment"

# shellcheck disable=SC1090
source "${HOME}/.bashrc"

log_success "Shell environment reloaded."

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Environment configuration completed successfully."

exit 0
