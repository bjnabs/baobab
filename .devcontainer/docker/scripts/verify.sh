#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Development Environment Verification
#
# Purpose:
#   Verify that the development container is correctly provisioned.
#
# This script checks for the availability of required development tools,
# reports their versions, and exits with a non-zero status if any required
# dependency is missing.
# ==============================================================================

set -Eeuo pipefail

PASS_COUNT=0
FAIL_COUNT=0

echo
echo "=================================================="
echo " BAOBAB Development Environment Verification"
echo "=================================================="
echo

check_command() {
    local name="$1"
    local version_command="$2"

    printf "%-18s" "${name}"

    if command -v "${name}" >/dev/null 2>&1; then
        version=$(eval "${version_command}" 2>/dev/null | head -n 1)

        printf "✔ Installed"

        if [ -n "${version}" ]; then
            printf " (%s)" "${version}"
        fi

        echo

        PASS_COUNT=$((PASS_COUNT + 1))
    else
        echo "✘ Not Installed"
        FAIL_COUNT=$((FAIL_COUNT + 1))
    fi
}

echo "Checking required development tools..."
echo

check_command git "git --version"
check_command python3 "python3 --version"
check_command node "node --version"
check_command npm "npm --version"
check_command java "java --version"
check_command docker "docker --version"
check_command gh "gh --version"
check_command jq "jq --version"
check_command tree "tree --version"

echo
echo "--------------------------------------------------"
echo " Verification Summary"
echo "--------------------------------------------------"

echo "Passed : ${PASS_COUNT}"
echo "Failed : ${FAIL_COUNT}"

echo

if [ "${FAIL_COUNT}" -eq 0 ]; then
    echo "✔ Development environment verification PASSED."
    exit 0
else
    echo "✘ Development environment verification FAILED."
    exit 1
fi

