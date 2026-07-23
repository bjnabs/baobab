#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : java.sh
# Purpose     : Verifies the Java Development Kit (JDK) installation and
#               configuration for the BAOBAB Development Environment.
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

log_header "Java Verification"

FAILED=0

###############################################################################
# Java Runtime
###############################################################################

log_section "Java Runtime"

if command_exists java; then

    log_pass "Java Runtime"
    log_info "$(java --version | head -n 1)"

else

    log_fail "Java Runtime"
    FAILED=1

fi

###############################################################################
# Java Compiler
###############################################################################

log_section "Java Compiler"

if command_exists javac; then

    log_pass "Java Compiler"
    log_info "$(javac --version)"

else

    log_fail "Java Compiler"
    FAILED=1

fi

###############################################################################
# JAVA_HOME
###############################################################################

log_section "JAVA_HOME"

if [[ -n "${JAVA_HOME:-}" ]]; then

    log_pass "JAVA_HOME"
    log_info "${JAVA_HOME}"

    if [[ -d "${JAVA_HOME}" ]]; then
        log_pass "JAVA_HOME directory"
    else
        log_warning "JAVA_HOME points to a non-existent directory."
    fi

else

    log_warning "JAVA_HOME is not configured."

fi

###############################################################################
# PATH Verification
###############################################################################

log_section "PATH"

JAVA_BINARY="$(command -v java || true)"

if [[ -n "${JAVA_BINARY}" ]]; then

    log_info "Java executable: ${JAVA_BINARY}"

else

    log_warning "Java executable not found on PATH."

fi

###############################################################################
# JDK Verification
###############################################################################

log_section "JDK"

if command_exists jar; then

    log_pass "jar"
    log_info "$(jar --version)"

else

    log_warning "jar utility not available."

fi

###############################################################################
# Android Compatibility
###############################################################################

log_section "Android Toolchain"

if [[ -n "${ANDROID_HOME:-}" ]]; then

    log_info "ANDROID_HOME=${ANDROID_HOME}"

else

    log_info "ANDROID_HOME is not configured (expected until Android SDK is installed)."

fi

###############################################################################
# Summary
###############################################################################

if [[ "${FAILED}" -eq 0 ]]; then

    log_blank
    log_success "Java verification completed successfully."

else

    log_blank
    log_error "Java verification failed."
    exit 1

fi

exit 0
