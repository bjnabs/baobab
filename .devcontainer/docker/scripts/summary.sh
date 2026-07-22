#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : summary.sh
# Purpose     : Displays a summary of the BAOBAB Development Environment.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
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

PROJECT_ROOT="$(get_project_root)"

log_header "BAOBAB Development Environment Summary"

###############################################################################
# Operating System
###############################################################################

log_section "Operating System"

log_info "Kernel       : $(uname -s)"
log_info "Release      : $(uname -r)"
log_info "Architecture : $(uname -m)"

###############################################################################
# Development Tools
###############################################################################

log_section "Development Tools"

tool_version() {
    local cmd="$1"

    if command_exists "${cmd}"; then
        case "${cmd}" in
            python3) python3 --version ;;
            node) node --version ;;
            npm) npm --version ;;
            java) java --version | head -n 1 ;;
            javac) javac --version ;;
            flutter) flutter --version | head -n 1 ;;
            dart) dart --version 2>&1 ;;
            docker) docker --version ;;
            git) git --version ;;
            uv) uv --version ;;
            *)
                "${cmd}" --version 2>/dev/null | head -n 1 || true
                ;;
        esac
    else
        echo "Not Installed"
    fi
}

TOOLS=(
    git
    python3
    uv
    node
    npm
    java
    javac
    flutter
    dart
    docker
)

for tool in "${TOOLS[@]}"; do
    printf "%-12s %s\n" "${tool}" "$(tool_version "${tool}")"
done

###############################################################################
# Repository
###############################################################################

log_section "Repository"

log_info "Project Root : ${PROJECT_ROOT}"

cd "${PROJECT_ROOT}"

if git rev-parse --git-dir >/dev/null 2>&1; then

    log_info "Branch       : $(git branch --show-current)"

    if git diff --quiet; then
        log_info "Status       : Clean"
    else
        log_info "Status       : Modified"
    fi

fi

###############################################################################
# Docker
###############################################################################

log_section "Docker Services"

if command_exists docker && file_exists "${PROJECT_ROOT}/compose.yaml"; then

    docker compose ps || true

else

    log_info "Docker Compose not available."

fi

###############################################################################
# Workspace
###############################################################################

log_section "Workspace"

FILE_COUNT="$(find "${PROJECT_ROOT}" -type f | wc -l | tr -d ' ')"
DIRECTORY_COUNT="$(find "${PROJECT_ROOT}" -type d | wc -l | tr -d ' ')"

log_info "Files        : ${FILE_COUNT}"
log_info "Directories  : ${DIRECTORY_COUNT}"

###############################################################################
# Environment Variables
###############################################################################

log_section "Environment"

for var in BAOBAB_HOME JAVA_HOME ANDROID_HOME; do

    if [[ -n "${!var:-}" ]]; then
        log_info "${var}=${!var}"
    fi

done

###############################################################################
# Finished
###############################################################################

log_blank
log_success "BAOBAB Development Environment is ready."

exit 0
