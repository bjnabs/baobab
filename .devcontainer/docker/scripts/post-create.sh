#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : post-create.sh
# Purpose     : Orchestrates the post-creation provisioning of the BAOBAB
#               Development Container.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
#
# Notes
# -----
# This script coordinates all installation, configuration and workspace
# preparation activities after the Dev Container has been created.
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ------------------------------------------------------------------------------
# Load Utilities
# ------------------------------------------------------------------------------

# shellcheck source=/dev/null
source "${SCRIPT_DIR}/utils/colors.sh"
source "${SCRIPT_DIR}/utils/functions.sh"
source "${SCRIPT_DIR}/utils/logging.sh"

log_header "BAOBAB Post-Create Provisioning"

###############################################################################
# Installation
###############################################################################

log_section "Installing Development Tools"

bash "${SCRIPT_DIR}/install/system.sh"
bash "${SCRIPT_DIR}/install/python.sh"
bash "${SCRIPT_DIR}/install/node.sh"
bash "${SCRIPT_DIR}/install/java.sh"
bash "${SCRIPT_DIR}/install/flutter.sh"
bash "${SCRIPT_DIR}/install/docker.sh"
bash "${SCRIPT_DIR}/install/database.sh"

log_success "Development tools installation completed."

###############################################################################
# Configuration
###############################################################################

log_section "Configuring Development Environment"

bash "${SCRIPT_DIR}/configure/environment.sh"
bash "${SCRIPT_DIR}/configure/git.sh"
bash "${SCRIPT_DIR}/configure/shell.sh"
bash "${SCRIPT_DIR}/configure/vscode.sh"
bash "${SCRIPT_DIR}/configure/paths.sh"

log_success "Environment configuration completed."

###############################################################################
# Workspace
###############################################################################

log_section "Preparing Workspace"

bash "${SCRIPT_DIR}/workspace/initialize.sh"
bash "${SCRIPT_DIR}/workspace/directories.sh"
bash "${SCRIPT_DIR}/workspace/permissions.sh"
bash "${SCRIPT_DIR}/workspace/cleanup.sh"

log_success "Workspace preparation completed."

###############################################################################
# Verification
###############################################################################

log_section "Verifying Development Environment"

bash "${SCRIPT_DIR}/verify.sh"

###############################################################################
# Summary
###############################################################################

log_section "Generating Summary"

bash "${SCRIPT_DIR}/summary.sh"

###############################################################################
# Completion
###############################################################################

log_blank
log_success "BAOBAB Development Environment provisioning completed successfully."

exit 0
