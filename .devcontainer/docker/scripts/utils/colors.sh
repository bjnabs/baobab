#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : colors.sh
# Purpose     : Defines ANSI colour and text formatting constants used by the
#               BAOBAB Development Environment Provisioning Framework.
#
# Author      : BAOBAB Contributors
# License     : Apache License 2.0
#
# Notes
# -----
# This script only defines colours and formatting.
# It intentionally contains no functions or business logic.
# ==============================================================================

# Prevent multiple sourcing
[[ -n "${BAOBAB_COLORS_LOADED:-}" ]] && return
readonly BAOBAB_COLORS_LOADED=1

###############################################################################
# Colour Support
###############################################################################

if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
    readonly COLOR_SUPPORTED=true
else
    readonly COLOR_SUPPORTED=false
fi

###############################################################################
# ANSI Colours
###############################################################################

if [[ "${COLOR_SUPPORTED}" == true ]]; then

    readonly RESET="\033[0m"

    readonly BLACK="\033[30m"
    readonly RED="\033[31m"
    readonly GREEN="\033[32m"
    readonly YELLOW="\033[33m"
    readonly BLUE="\033[34m"
    readonly MAGENTA="\033[35m"
    readonly CYAN="\033[36m"
    readonly WHITE="\033[37m"

    readonly BRIGHT_BLACK="\033[90m"
    readonly BRIGHT_RED="\033[91m"
    readonly BRIGHT_GREEN="\033[92m"
    readonly BRIGHT_YELLOW="\033[93m"
    readonly BRIGHT_BLUE="\033[94m"
    readonly BRIGHT_MAGENTA="\033[95m"
    readonly BRIGHT_CYAN="\033[96m"
    readonly BRIGHT_WHITE="\033[97m"

    readonly BOLD="\033[1m"
    readonly DIM="\033[2m"
    readonly ITALIC="\033[3m"
    readonly UNDERLINE="\033[4m"

else

    readonly RESET=""

    readonly BLACK=""
    readonly RED=""
    readonly GREEN=""
    readonly YELLOW=""
    readonly BLUE=""
    readonly MAGENTA=""
    readonly CYAN=""
    readonly WHITE=""

    readonly BRIGHT_BLACK=""
    readonly BRIGHT_RED=""
    readonly BRIGHT_GREEN=""
    readonly BRIGHT_YELLOW=""
    readonly BRIGHT_BLUE=""
    readonly BRIGHT_MAGENTA=""
    readonly BRIGHT_CYAN=""
    readonly BRIGHT_WHITE=""

    readonly BOLD=""
    readonly DIM=""
    readonly ITALIC=""
    readonly UNDERLINE=""

fi
