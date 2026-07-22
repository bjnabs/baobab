#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : paths.sh
# Purpose     : Configures common PATH entries and project-specific environment
#               variables for the BAOBAB Development Environment.
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

log_header "PATH Configuration"

PROJECT_ROOT="$(get_project_root)"
BASHRC="${HOME}/.bashrc"

###############################################################################
# BAOBAB PATH Configuration
###############################################################################

log_section "Shell PATH"

START_MARKER="# >>> BAOBAB PATH CONFIGURATION >>>"
END_MARKER="# <<< BAOBAB PATH CONFIGURATION <<<"

if grep -Fq "${START_MARKER}" "${BASHRC}"; then

    log_info "BAOBAB PATH configuration already exists."

else

cat >> "${BASHRC}" <<EOF

${START_MARKER}

###############################################################################
# BAOBAB Project
###############################################################################

export BAOBAB_HOME="${PROJECT_ROOT}"

###############################################################################
# Python
###############################################################################

export PATH="\$HOME/.local/bin:\$PATH"

###############################################################################
# Flutter
###############################################################################

if [ -d "\$HOME/flutter/bin" ]; then
    export PATH="\$HOME/flutter/bin:\$PATH"
fi

###############################################################################
# Android SDK
###############################################################################

if [ -n "\${ANDROID_HOME:-}" ]; then
    export PATH="\$ANDROID_HOME/platform-tools:\$PATH"
    export PATH="\$ANDROID_HOME/emulator:\$PATH"
    export PATH="\$ANDROID_HOME/cmdline-tools/latest/bin:\$PATH"
fi

###############################################################################
# Java
###############################################################################

if [ -n "\${JAVA_HOME:-}" ]; then
    export PATH="\$JAVA_HOME/bin:\$PATH"
fi

###############################################################################
# Node.js
###############################################################################

if [ -d "${PROJECT_ROOT}/services/frontend/node_modules/.bin" ]; then
    export PATH="${PROJECT_ROOT}/services/frontend/node_modules/.bin:\$PATH"
fi

###############################################################################
# Python Virtual Environment
###############################################################################

if [ -d "${PROJECT_ROOT}/.venv/bin" ]; then
    export PATH="${PROJECT_ROOT}/.venv/bin:\$PATH"
fi

${END_MARKER}

EOF

    log_success "BAOBAB PATH configuration added."

fi

###############################################################################
# Reload Shell
###############################################################################

log_section "Reload Shell"

# shellcheck disable=SC1090
source "${BASHRC}"

log_success "Shell configuration reloaded."

###############################################################################
# Display Important Paths
###############################################################################

log_section "Configured Paths"

log_info "BAOBAB_HOME : ${PROJECT_ROOT}"
log_info "HOME         : ${HOME}"
log_info "PATH         : ${PATH}"

###############################################################################
# Complete
###############################################################################

log_blank
log_success "PATH configuration completed successfully."

exit 0
