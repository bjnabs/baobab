#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : functions.sh
# Purpose     : Provides reusable helper functions for the BAOBAB Development
#               Environment Provisioning Framework.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
#
# Notes
# -----
# This script contains generic helper functions only.
# It intentionally contains no logging, installation, verification,
# or provisioning logic.
# ==============================================================================

# Prevent multiple sourcing
[[ -n "${BAOBAB_FUNCTIONS_LOADED:-}" ]] && return
readonly BAOBAB_FUNCTIONS_LOADED=1

###############################################################################
# Paths
###############################################################################

get_script_directory() {
    local source="${BASH_SOURCE[1]}"
    while [ -h "$source" ]; do
        local dir
        dir="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
        source="$(readlink "$source")"
        [[ "$source" != /* ]] && source="$dir/$source"
    done

    cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd
}

get_project_root() {
    local script_dir
    script_dir="$(get_script_directory)"

    (
        cd "${script_dir}/../../../../.." >/dev/null 2>&1
        pwd
    )
}

###############################################################################
# Time
###############################################################################

timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

###############################################################################
# File System
###############################################################################

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

file_exists() {
    [[ -f "$1" ]]
}

directory_exists() {
    [[ -d "$1" ]]
}

ensure_directory() {
    mkdir -p "$1"
}

ensure_executable() {
    chmod +x "$1"
}

###############################################################################
# String Utilities
###############################################################################

trim() {
    local value="$*"

    value="${value#"${value%%[![:space:]]*}"}"
    value="${value%"${value##*[![:space:]]}"}"

    printf '%s\n' "$value"
}

join_by() {
    local delimiter="$1"
    shift

    local first=1

    for item in "$@"; do
        if [[ $first -eq 1 ]]; then
            printf "%s" "$item"
            first=0
        else
            printf "%s%s" "$delimiter" "$item"
        fi
    done

    printf "\n"
}

###############################################################################
# Environment
###############################################################################

is_linux() {
    [[ "$(uname -s)" == "Linux" ]]
}

is_macos() {
    [[ "$(uname -s)" == "Darwin" ]]
}

is_root() {
    [[ "${EUID}" -eq 0 ]]
}

###############################################################################
# Execution
###############################################################################

run_command() {
    "$@"
}

safe_source() {
    local script="$1"

    if [[ -f "$script" ]]; then
        # shellcheck source=/dev/null
        source "$script"
    else
        return 1
    fi
}
