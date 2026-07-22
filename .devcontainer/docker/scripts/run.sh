#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : run.sh
# Purpose     : Entry point for the BAOBAB Dev Container provisioning framework.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ------------------------------------------------------------------------------
# Helper
# ------------------------------------------------------------------------------

run_script() {

    local script="$1"

    if [[ ! -f "${script}" ]]; then
        echo "Script not found: ${script}"
        exit 1
    fi

    chmod +x "${script}"

    echo
    echo "=============================================================="
    echo "Running: $(basename "${script}")"
    echo "=============================================================="

    "${script}"
}

# ------------------------------------------------------------------------------
# Commands
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
        ;;

    *)

        echo "Unknown command: ${1}"

        echo

        "${BASH_SOURCE%/*}/run.sh" help

        exit 1
        ;;

esac

exit 0
