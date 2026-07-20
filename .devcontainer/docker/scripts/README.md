# Development Container Scripts

## Purpose

This directory contains scripts used to provision, configure, and validate the BAOBAB Development Container.

These scripts support GitHub Codespaces and Visual Studio Code Dev Containers by encapsulating development environment logic outside the Dockerfile.

Keeping provisioning logic in dedicated scripts improves readability, maintainability, and reuse while allowing the Dockerfile to remain focused on defining the container image.

---

# Directory Structure

```text
scripts/
├── bootstrap.sh
├── post-create.sh
├── verify.sh
└── README.md
```

---

# File Responsibilities

## `bootstrap.sh`

Initialises the development environment before project-specific configuration is applied.

Typical responsibilities include:

* Preparing environment variables
* Configuring common shell settings
* Executing shared helper functions
* Performing lightweight prerequisite checks

This script should remain generic and reusable.

---

## `post-create.sh`

Executed after the Development Container has been created.

Typical responsibilities include:

* Verifying installed tooling
* Initialising repository-specific configuration
* Preparing the development workspace
* Running non-destructive setup tasks
* Displaying useful onboarding information

This script should be safe to execute multiple times.

---

## `verify.sh`

Validates that the Development Container has been configured correctly.

Typical verification tasks include:

* Python version
* Node.js version
* Java version
* Docker CLI availability
* GitHub CLI availability
* Development tool diagnostics

The script should exit with a non-zero status if a critical dependency is unavailable.

---

# Engineering Principles

The scripts in this directory should adhere to the following principles:

* Single Responsibility Principle
* Idempotent execution wherever practical
* Small, modular, and reusable functions
* Clear logging and meaningful error messages
* Fail fast on unrecoverable errors
* Avoid hard-coded paths and configuration values
* Use environment variables where appropriate

---

# Future Expansion

As BAOBAB evolves, additional scripts may be introduced to support:

* Flutter SDK configuration
* `uv` environment preparation
* Git hook installation
* Local certificate management
* Repository bootstrap automation
* Development diagnostics

Scripts should remain focused and composable rather than becoming large, multi-purpose utilities.

---

# Ownership

This directory is maintained by the BAOBAB Engineering Team.

Changes to provisioning or verification scripts should be reviewed through the project's standard pull request process and kept aligned with the Development Container documentation.
