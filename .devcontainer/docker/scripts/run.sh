#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : run.sh
# Purpose     : Main entry point for the BAOBAB Development Environment
#               Provisioning Framework.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
#
# Notes
# -----
# This script orchestrates the execution of the provisioning framework.
# ==============================================================================
#
# Usage:
#
#   ./run.sh
#   ./run.sh bootstrap
#   ./run.sh post-create
#   ./run.sh verify
#   ./run.sh summary
#
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load utilities
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/utils/colors.sh"
source "${SCRIPT_DIR}/utils/functions.sh"
source "${SCRIPT_DIR}/utils/logging.sh"

###############################################################################
# Usage
###############################################################################

usage() {

cat << EOF

BAOBAB Development Environment Provisioning Framework

Usage:

  run.sh [command]

Commands

  bootstrap      Prepare the workspace.
  post-create    Execute provisioning.
  verify         Verify the development environment.
  summary        Display environment summary.
  all            Execute the complete workflow.

Examples

  ./run.sh
  ./run.sh all
  ./run.sh verify

EOF

}

###############################################################################
# Execute
###############################################################################

run_bootstrap() {
    bash "${SCRIPT_DIR}/bootstrap.sh"
}

run_post_create() {
    bash "${SCRIPT_DIR}/post-create.sh"
}

run_verify() {
    bash "${SCRIPT_DIR}/verify.sh"
}

run_summary() {
    bash "${SCRIPT_DIR}/summary.sh"
}

run_all() {

    log_header "BAOBAB Provisioning"

    run_bootstrap
    run_post_create
    run_verify
    run_summary
}

###############################################################################
# Main
###############################################################################

COMMAND="${1:-all}"

case "${COMMAND}" in

    bootstrap)
        run_bootstrap
        ;;

    post-create)
        run_post_create
        ;;

    verify)
        run_verify
        ;;

    summary)
        run_summary
        ;;

    all)
        run_all
        ;;

    help|-h|--help)
        usage
        ;;

    *)
        log_error "Unknown command: ${COMMAND}"
        echo
        usage
        exit 1
        ;;

esac

exit 0
