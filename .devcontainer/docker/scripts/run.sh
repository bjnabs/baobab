```bash
#!/usr/bin/env bash

# ==============================================================================
# BAOBAB Development Container Orchestrator
#
# Purpose:
#   Executes the development container provisioning lifecycle in the
#   prescribed order.
#
# Lifecycle:
#
#   bootstrap.sh
#          │
#          ▼
#   post-create.sh
#          │
#          ▼
#     verify.sh
# ==============================================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo
echo "=================================================="
echo " BAOBAB Development Container Initialisation"
echo "=================================================="
echo

run_step() {
    local script="$1"

    echo
    echo "▶ Running ${script}..."
    echo

    "${SCRIPT_DIR}/${script}"

    echo
    echo "✔ ${script} completed successfully."
}

run_step "bootstrap.sh"
run_step "post-create.sh"
run_step "verify.sh"

echo
echo "=================================================="
echo " BAOBAB Development Environment Ready"
echo "=================================================="
echo
```
