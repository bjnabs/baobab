#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Enterprise Platform
#
# Script      : vscode.sh
# Purpose     : Configures Visual Studio Code for the BAOBAB Development
#               Environment.
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
source "${SCRIPT_DIR}/../utils/colors.sh"
source "${SCRIPT_DIR}/../utils/functions.sh"
source "${SCRIPT_DIR}/../utils/logging.sh"

log_header "Visual Studio Code Configuration"

PROJECT_ROOT="$(get_project_root)"
VSCODE_DIR="${PROJECT_ROOT}/.vscode"

###############################################################################
# Create Workspace Directory
###############################################################################

log_section "Workspace"

ensure_directory "${VSCODE_DIR}"

###############################################################################
# settings.json
###############################################################################

log_section "settings.json"

SETTINGS_FILE="${VSCODE_DIR}/settings.json"

if [[ ! -f "${SETTINGS_FILE}" ]]; then

cat > "${SETTINGS_FILE}" <<'EOF'
{
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.fixAll": "explicit",
        "source.organizeImports": "explicit"
    },

    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true,

    "terminal.integrated.defaultProfile.linux": "bash",

    "python.defaultInterpreterPath": ".venv/bin/python",

    "python.terminal.activateEnvironment": true,

    "typescript.tsdk": "services/frontend/node_modules/typescript/lib",

    "search.exclude": {
        "**/.git": true,
        "**/.next": true,
        "**/__pycache__": true,
        "**/.pytest_cache": true,
        "**/.venv": true
    }
}
EOF

    log_success "settings.json created."

else

    log_info "settings.json already exists."

fi

###############################################################################
# extensions.json
###############################################################################

log_section "extensions.json"

EXTENSIONS_FILE="${VSCODE_DIR}/extensions.json"

if [[ ! -f "${EXTENSIONS_FILE}" ]]; then

cat > "${EXTENSIONS_FILE}" <<'EOF'
{
    "recommendations": [
        "ms-python.python",
        "ms-python.vscode-pylance",
        "charliermarsh.ruff",
        "ms-azuretools.vscode-docker",
        "esbenp.prettier-vscode",
        "dbaeumer.vscode-eslint",
        "bradlc.vscode-tailwindcss",
        "ms-vscode.makefile-tools",
        "eamodio.gitlens",
        "github.vscode-github-actions",
        "ms-kubernetes-tools.vscode-kubernetes-tools",
        "redhat.vscode-yaml",
        "humao.rest-client"
    ]
}
EOF

    log_success "extensions.json created."

else

    log_info "extensions.json already exists."

fi

###############################################################################
# launch.json
###############################################################################

log_section "launch.json"

LAUNCH_FILE="${VSCODE_DIR}/launch.json"

if [[ ! -f "${LAUNCH_FILE}" ]]; then

cat > "${LAUNCH_FILE}" <<'EOF'
{
    "version": "0.2.0",
    "configurations": []
}
EOF

    log_success "launch.json created."

else

    log_info "launch.json already exists."

fi

###############################################################################
# tasks.json
###############################################################################

log_section "tasks.json"

TASKS_FILE="${VSCODE_DIR}/tasks.json"

if [[ ! -f "${TASKS_FILE}" ]]; then

cat > "${TASKS_FILE}" <<'EOF'
{
    "version": "2.0.0",
    "tasks": []
}
EOF

    log_success "tasks.json created."

else

    log_info "tasks.json already exists."

fi

###############################################################################
# Complete
###############################################################################

log_blank
log_success "Visual Studio Code configuration completed successfully."

exit 0
