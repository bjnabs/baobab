#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : run.sh
# Purpose     : Entry point for the BAOBAB Dev Container provisioning framework.
#
# Description :
#   Dispatches high-level provisioning commands to the appropriate orchestration
#   scripts. This script intentionally contains no installation or provisioning
#   logic and serves only as the single entry point into the BAOBAB development
#   environment.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ------------------------------------------------------------------------------
# Display Help
# ------------------------------------------------------------------------------

show_help() {

cat <<EOF

BAOBAB Dev Container

Usage

    run.sh [command]

Commands

    bootstrap      Complete machine provisioning

    post-create    Configure the workspace after the container starts
                   (Default)

    verify         Execute every verification module

    summary        Display an environment summary

    help           Show this help

EOF

}

# ------------------------------------------------------------------------------
# Execute Script
# ------------------------------------------------------------------------------

run_script() {

    local script="$1"

    if [[ ! -f "$script" ]]; then
        echo "ERROR: Script not found:"
        echo "  $script"
        exit 1
    fi

    echo
    echo "=============================================================="
    echo "Running: $(basename "$script")"
    echo "=============================================================="
    echo

    # Execute explicitly with Bash to avoid dependency on executable bits.
    bash "$script"
}

# ------------------------------------------------------------------------------
# Command Dispatcher
# ------------------------------------------------------------------------------

case "${1:-post-create}" in

    bootstrap)
        run_script "${SCRIPT_DIR}/bootstrap.sh"
        ;;

    post-create)
        run_script "${SCRIPT_DIR}/post-create.sh"
        ;;

    verify)
        run_script "${SCRIPT_DIR}/verify.sh"
        ;;

    summary)
        run_script "${SCRIPT_DIR}/summary.sh"
        ;;

    help|-h|--help)
        show_help
        ;;

    *)
        echo "ERROR: Unknown command: ${1}"
        echo
        show_help
        exit 1
        ;;

esac

exit 0
