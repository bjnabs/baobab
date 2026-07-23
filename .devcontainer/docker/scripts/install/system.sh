#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : system.sh
# Purpose     : Installs and updates core operating system packages required by
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

log_header "System Installation"

###############################################################################
# Update Package Index
###############################################################################

log_section "Updating Package Index"

sudo apt-get update

###############################################################################
# Install Core Packages
###############################################################################

log_section "Installing Core Packages"

sudo apt-get install -y \
    build-essential \
    curl \
    wget \
    unzip \
    zip \
    git \
    jq \
    tree \
    file \
    ca-certificates \
    software-properties-common \
    apt-transport-https \
    gnupg \
    lsb-release

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
log_success "System packages installed successfully."

exit 0
