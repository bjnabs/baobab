#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : bootstrap.sh
# Purpose     : Performs complete provisioning of the BAOBAB Development
#               Environment.
#
# Description :
#   Orchestrates the complete provisioning lifecycle for the BAOBAB
#   Development Environment.
#
#   Execution Order:
#
#       1. Install development toolchains
#       2. Configure the environment
#       3. Initialize the workspace
#       4. Verify the installation
#       5. Display the environment summary
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ------------------------------------------------------------------------------
# Execute Script
# ------------------------------------------------------------------------------

run_step() {

    local script="$1"

    if [[ ! -f "$script" ]]; then
        echo "ERROR: Missing script:"
        echo "  $script"
        exit 1
    fi

    echo
    echo "=================================================================="
    echo "Running: $(basename "$script")"
    echo "=================================================================="
    echo

    # Execute explicitly with Bash rather than relying on executable bits.
    bash "$script"
}

# ------------------------------------------------------------------------------
# Install
# ------------------------------------------------------------------------------

echo
echo "====================== INSTALL ======================"

INSTALL_SCRIPTS=(
    system.sh
    python.sh
    node.sh
    java.sh
    database.sh
    docker.sh
    flutter.sh
    android_sdk.sh
    dependencies.sh
)

for script in "${INSTALL_SCRIPTS[@]}"; do
    run_step "${SCRIPT_DIR}/install/${script}"
done

# ------------------------------------------------------------------------------
# Configure
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# Workspace
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# Verify
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# Summary
# ------------------------------------------------------------------------------

echo
echo "====================== SUMMARY ======================"

run_step "${SCRIPT_DIR}/summary.sh"

echo
echo "====================================================="
echo " BAOBAB Development Environment Ready"
echo "====================================================="

exit 0
