#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : verify.sh
# Purpose     : Executes all BAOBAB verification modules.
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
        echo "Missing verification script: ${script}"
        exit 1
    fi

    chmod +x "${script}"

    echo
    echo "------------------------------------------------------------"
    echo "Running $(basename "${script}")"
    echo "------------------------------------------------------------"

    "${script}"
}

###############################################################################
# Verification Modules
###############################################################################

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

echo
echo "============================================================"
echo " BAOBAB Development Environment Verification"
echo "============================================================"

FAILED=0

for script in "${VERIFY_SCRIPTS[@]}"; do

    if ! run_step "${SCRIPT_DIR}/verify/${script}"; then
        FAILED=1
    fi

done

###############################################################################
# Final Result
###############################################################################

echo

if [[ "${FAILED}" -eq 0 ]]; then

    echo "============================================================"
    echo " All verification modules completed successfully."
    echo "============================================================"

else

    echo "============================================================"
    echo " One or more verification modules failed."
    echo "============================================================"

    exit 1

fi

exit 0
