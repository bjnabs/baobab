#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Development Container Post-Create
#
# Purpose:
#   Perform repository-specific configuration after the development
#   container has been created.
# ==============================================================================

set -Eeuo pipefail

echo
echo "Executing repository post-create tasks..."
echo

# ------------------------------------------------------------------------------
# Future post-create tasks
# ------------------------------------------------------------------------------
#
# - Configure uv
# - Configure Git hooks
# - Initialise project tooling
# - Install optional development dependencies
#
# ------------------------------------------------------------------------------

echo "Post-create tasks completed successfully."