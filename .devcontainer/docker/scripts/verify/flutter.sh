#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : flutter.sh
# Purpose     : Verifies the Flutter and Dart development environment.
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

log_header "Flutter Verification"

PROJECT_ROOT="$(get_project_root)"
MOBILE_DIR="${PROJECT_ROOT}/services/mobile"

FAILED=0

###############################################################################
# Flutter SDK
###############################################################################

log_section "Flutter SDK"

if command_exists flutter; then

    log_pass "Flutter"
    log_info "$(flutter --version | head -n 1)"

else

    log_fail "Flutter"
    FAILED=1

fi

###############################################################################
# Dart SDK
###############################################################################

log_section "Dart SDK"

if command_exists dart; then

    log_pass "Dart"
    log_info "$(dart --version 2>&1)"

else

    log_fail "Dart"
    FAILED=1

fi

###############################################################################
# Mobile Project
###############################################################################

log_section "Mobile Project"

if directory_exists "${MOBILE_DIR}"; then

    log_pass "services/mobile"

    if file_exists "${MOBILE_DIR}/pubspec.yaml"; then
        log_pass "pubspec.yaml"
    else
        log_warning "pubspec.yaml not found."
    fi

else

    log_warning "Mobile project has not been initialized."

fi

###############################################################################
# Flutter Doctor
###############################################################################

log_section "Flutter Doctor"

if command_exists flutter; then

    if flutter doctor >/dev/null 2>&1; then

        log_pass "Flutter Doctor"

    else

        log_warning "Flutter Doctor reported issues."
        flutter doctor

    fi

fi

###############################################################################
# Android SDK
###############################################################################

log_section "Android SDK"

if [[ -n "${ANDROID_HOME:-}" ]]; then

    log_pass "ANDROID_HOME"
    log_info "${ANDROID_HOME}"

    if [[ -d "${ANDROID_HOME}" ]]; then
        log_pass "Android SDK"
    else
        log_warning "ANDROID_HOME directory does not exist."
    fi

else

    log_info "ANDROID_HOME not configured."

fi

###############################################################################
# Android Platform Tools
###############################################################################

log_section "Platform Tools"

if command_exists adb; then

    log_pass "adb"
    log_info "$(adb version | head -n 1)"

else

    log_info "adb not installed."

fi

###############################################################################
# Emulator
###############################################################################

log_section "Android Emulator"

if command_exists emulator; then

    log_pass "Android Emulator"

else

    log_info "Android Emulator not installed."

fi

###############################################################################
# Summary
###############################################################################

if [[ "${FAILED}" -eq 0 ]]; then

    log_blank
    log_success "Flutter verification completed successfully."

else

    log_blank
    log_error "Flutter verification failed."
    exit 1

fi

exit 0
