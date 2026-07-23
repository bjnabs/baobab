#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : java.sh
# Purpose     : Installs and configures the Java Development Kit (JDK) for the
#               BAOBAB Development Environment.
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

log_header "Java Installation"

###############################################################################
# Verify Java
###############################################################################

log_section "Java Development Kit"

if command_exists java && command_exists javac; then

    log_info "Java is already installed."
    log_info "$(java --version | head -n 1)"

else

    log_info "Installing OpenJDK..."

    sudo apt-get update

    sudo apt-get install -y \
        openjdk-21-jdk

    log_success "OpenJDK installed."

fi

###############################################################################
# Verify Java Compiler
###############################################################################

log_section "Java Compiler"

if command_exists javac; then

    log_info "$(javac --version)"

else

    log_error "Java compiler (javac) is not available."
    exit 1

fi

###############################################################################
# Configure JAVA_HOME
###############################################################################

log_section "JAVA_HOME"

JAVA_HOME_PATH="$(dirname "$(dirname "$(readlink -f "$(command -v javac)")")")"

if [[ -n "${JAVA_HOME_PATH}" ]]; then

    export JAVA_HOME="${JAVA_HOME_PATH}"

    if ! grep -q "JAVA_HOME" "${HOME}/.bashrc"; then
        {
            echo ""
            echo "# Java"
            echo "export JAVA_HOME=${JAVA_HOME_PATH}"
            echo 'export PATH="$JAVA_HOME/bin:$PATH"'
        } >> "${HOME}/.bashrc"
    fi

    log_info "JAVA_HOME=${JAVA_HOME}"

else

    log_error "Unable to determine JAVA_HOME."
    exit 1

fi

###############################################################################
# Verify Environment
###############################################################################

log_section "Verification"

log_info "$(java --version | head -n 1)"
log_info "$(javac --version)"

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Java environment configured successfully."

exit 0
