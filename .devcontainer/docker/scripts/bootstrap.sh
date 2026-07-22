#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : bootstrap.sh
# Purpose     : Performs complete provisioning of the BAOBAB Development
#               Environment.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

###############################################################################
# Helper
###############################################################################

run_step() {

    local script="$1"

    if [[ ! -f "${script}" ]]; then
        echo "Missing script: ${script}"
        exit 1
    fi

    chmod +x "${script}"

    echo
    echo "=================================================================="
    echo "Running $(basename "${script}")"
    echo "=================================================================="

    "${script}"
}

###############################################################################
# Install
###############################################################################

echo
echo "====================== INSTALL ======================"

INSTALL_SCRIPTS=(
    system.sh
    python.sh
    node.sh
    java.sh
    flutter.sh
    docker.sh
    database.sh
)

for script in "${INSTALL_SCRIPTS[@]}"; do
    run_step "${SCRIPT_DIR}/install/${script}"
done

###############################################################################
# Configure
###############################################################################

echo
echo "===================== CONFIGURE ====================="

CONFIGURE_SCRIPTS=(
    environment.sh
    git.sh
    shell.sh
    vscode.sh
    paths.sh
)

for script in "${CONFIGURE_SCRIPTS[@]}"; do
    run_step "${SCRIPT_DIR}/configure/${script}"
done

###############################################################################
# Workspace
###############################################################################

echo
echo "===================== WORKSPACE ====================="

WORKSPACE_SCRIPTS=(
    initialize.sh
    directories.sh
    permissions.sh
    cleanup.sh
)

for script in "${WORKSPACE_SCRIPTS[@]}"; do
    run_step "${SCRIPT_DIR}/workspace/${script}"
done

###############################################################################
# Verify
###############################################################################

echo
echo "====================== VERIFY ======================="

VERIFY_SCRIPTS=(
    system.sh
    python.sh
    node.sh
    java.sh
    flutter.sh
    docker.sh
    database.sh
    workspace.sh
)

for script in "${VERIFY_SCRIPTS[@]}"; do
    run_step "${SCRIPT_DIR}/verify/${script}"
done

###############################################################################
# Summary
###############################################################################

echo
echo "====================== SUMMARY ======================"

run_step "${SCRIPT_DIR}/summary.sh"

echo
echo "====================================================="
echo " BAOBAB Development Environment Ready"
echo "====================================================="

exit 0
