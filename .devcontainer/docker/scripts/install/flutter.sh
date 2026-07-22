#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : flutter.sh
# Purpose     : Installs and configures the Flutter and Dart SDKs for the
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

log_header "Flutter Installation"

PROJECT_ROOT="$(get_project_root)"
FLUTTER_HOME="${HOME}/flutter"
FLUTTER_BIN="${FLUTTER_HOME}/bin"

###############################################################################
# Install Flutter SDK
###############################################################################

log_section "Flutter SDK"

if command_exists flutter; then

    log_info "Flutter is already installed."
    log_info "$(flutter --version | head -n 1)"

else

    log_info "Installing Flutter SDK..."

    if [[ ! -d "${FLUTTER_HOME}" ]]; then

        git clone https://github.com/flutter/flutter.git \
            --branch stable \
            "${FLUTTER_HOME}"

    fi

    export PATH="${FLUTTER_BIN}:${PATH}"

    if ! grep -q "flutter/bin" "${HOME}/.bashrc"; then
        {
            echo ""
            echo "# Flutter"
            echo "export PATH=\"${FLUTTER_BIN}:\$PATH\""
        } >> "${HOME}/.bashrc"
    fi

    log_success "Flutter SDK installed."

fi

###############################################################################
# Verify Dart
###############################################################################

log_section "Dart SDK"

if command_exists dart; then

    log_info "$(dart --version 2>&1)"

else

    log_warning "Dart will become available after Flutter is added to PATH."

fi

###############################################################################
# Flutter Precache
###############################################################################

log_section "Flutter Cache"

flutter precache

log_success "Flutter cache downloaded."

###############################################################################
# Flutter Doctor
###############################################################################

log_section "Flutter Doctor"

flutter doctor

###############################################################################
# Mobile Dependencies
###############################################################################

log_section "Mobile Dependencies"

MOBILE_DIR="${PROJECT_ROOT}/services/mobile"

if directory_exists "${MOBILE_DIR}" && file_exists "${MOBILE_DIR}/pubspec.yaml"; then

    cd "${MOBILE_DIR}"

    flutter pub get

    log_success "Flutter project dependencies installed."

else

    log_warning "Mobile project not initialized. Skipping dependency installation."

fi

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Flutter environment configured successfully."

exit 0
