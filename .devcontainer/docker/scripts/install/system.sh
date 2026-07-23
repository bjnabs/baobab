#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : system.sh
# Purpose     : Verifies and prepares the operating system for the BAOBAB
#               Development Environment.
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
source "${SCRIPT_DIR}/../config/versions.sh"

log_header "System Installation"

###############################################################################
# Helper Functions
###############################################################################

ensure_package() {

    local package="$1"

    if dpkg -s "${package}" >/dev/null 2>&1; then

        log_info "${package} already installed."

    else

        log_info "Installing ${package}..."

        sudo apt-get install -y "${package}"

        log_success "${package} installed."

    fi
}

###############################################################################
# Verify Operating System
###############################################################################

log_section "Operating System"

CURRENT_UBUNTU="$(lsb_release -rs)"

log_info "Detected Ubuntu ${CURRENT_UBUNTU}"

if [[ "${CURRENT_UBUNTU}" != "${UBUNTU_VERSION}" ]]; then
    log_warning "Configured target Ubuntu version: ${UBUNTU_VERSION}"
fi

###############################################################################
# Update Package Index
###############################################################################

log_section "Updating Package Index"

sudo apt-get update

###############################################################################
# Verify Core Packages
###############################################################################

log_section "Core Packages"

SYSTEM_PACKAGES=(
    apt-transport-https
    build-essential
    ca-certificates
    curl
    file
    git
    gnupg
    jq
    lsb-release
    software-properties-common
    tree
    unzip
    wget
    zip
)

for package in "${SYSTEM_PACKAGES[@]}"; do
    ensure_package "${package}"
done

###############################################################################
# Configure Package Repositories
###############################################################################

log_section "Package Repositories"

#
# Deadsnakes is only required for Ubuntu releases that do not provide the
# desired Python version.
#

if [[ "${CURRENT_UBUNTU}" < "26.04" ]]; then

    if ! grep -Rqs "deadsnakes" \
        /etc/apt/sources.list \
        /etc/apt/sources.list.d \
        2>/dev/null; then

        log_info "Adding Deadsnakes Python repository..."

        sudo add-apt-repository -y ppa:deadsnakes/ppa

        sudo apt-get update

        log_success "Deadsnakes repository added."

    else

        log_info "Deadsnakes repository already configured."

    fi

else

    log_info "Ubuntu ${CURRENT_UBUNTU} provides modern Python packages."
    log_info "Skipping Deadsnakes repository."

fi

#
# Additional repositories are configured by their respective installers:
#
#   install/node.sh      → NodeSource
#   install/docker.sh    → Docker CE
#   install/database.sh  → PostgreSQL PGDG
#   install/flutter.sh   → Flutter
#

###############################################################################
# Cleanup
###############################################################################

log_section "Cleaning Package Cache"

sudo apt-get autoremove -y
sudo apt-get autoclean -y

###############################################################################
# Complete
###############################################################################

log_blank
log_success "System provisioning completed successfully."

exit 0
