#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : post-create.sh
# Purpose     : Performs post-creation configuration for GitHub Codespaces
#               and VS Code Dev Containers.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

###############################################################################
# Helper Functions
###############################################################################

print_banner() {

    local title="$1"

    echo
    echo "=================================================================="
    printf " %-64s\n" "${title}"
    echo "=================================================================="
}

run_step() {

    local script="$1"

    if [[ ! -f "${script}" ]]; then
        echo "ERROR: Missing script:"
        echo "  ${script}"
        exit 1
    fi

    if [[ ! -x "${script}" ]]; then
        chmod +x "${script}"
    fi

    echo
    echo ">>> Running $(basename "${script}")"

    "${script}"
}

###############################################################################
# Configure Development Environment
###############################################################################

print_banner "CONFIGURE"

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
# Prepare Workspace
###############################################################################

print_banner "WORKSPACE"

WORKSPACE_SCRIPTS=(
    initialize.sh
    directories.sh
    permissions.sh
)

for script in "${WORKSPACE_SCRIPTS[@]}"; do
    run_step "${SCRIPT_DIR}/workspace/${script}"
done

###############################################################################
# Verify Development Environment
###############################################################################

print_banner "VERIFY"

run_step "${SCRIPT_DIR}/verify.sh"

###############################################################################
# Display Summary
###############################################################################

print_banner "SUMMARY"

run_step "${SCRIPT_DIR}/summary.sh"

###############################################################################
# Complete
###############################################################################

print_banner "POST-CREATE COMPLETE"

echo "✓ BAOBAB Dev Container is ready."
echo

exit 0
