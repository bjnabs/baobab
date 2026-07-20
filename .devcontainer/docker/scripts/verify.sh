#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Development Environment Verification
#
# Purpose:
#   Verify that the required development tools are available.
# ==============================================================================

set -Eeuo pipefail

echo
echo "Verifying development environment..."
echo

check_command() {
    local command="$1"

    if command -v "$command" >/dev/null 2>&1; then
        printf "✔ %-12s %s\n" "$command" "$("$command" --version | head -n 1)"
    else
        printf "✘ %-12s Not Installed\n" "$command"
    fi
}

check_command git
check_command python3
check_command node
check_command java
check_command docker
check_command gh

echo
echo "Development environment verification completed."