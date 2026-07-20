# BAOBAB Development Container

## Purpose

The BAOBAB Development Container provides a consistent, reproducible, and cloud-ready development environment for all contributors.

It is used by GitHub Codespaces and Visual Studio Code Dev Containers to ensure every developer works in an identical environment with minimal setup.

---

# Directory Structure

```text
.devcontainer/
├── devcontainer.json
├── README.md
└── docker/
    ├── Dockerfile
    └── scripts/
```

---

# Component Responsibilities

## `devcontainer.json`

Defines how GitHub Codespaces and Visual Studio Code provision the BAOBAB development environment.

Responsibilities include:

* Development container configuration
* Dev Container Features
* Visual Studio Code settings
* Recommended extensions
* Forwarded development ports
* Workspace behaviour

---

## `docker/Dockerfile`

Defines the development container image.

Its responsibilities are limited to:

* Selecting the base image
* Defining image metadata
* Configuring the container environment
* Providing the development workspace

It does **not** install application services or define runtime orchestration.

Application runtime is managed separately through Docker Compose.

---

## `docker/scripts/`

Contains shell scripts used to provision and configure the development environment.

Typical responsibilities include:

* Installing development tooling
* Configuring shell environments
* Bootstrapping the workspace
* Performing post-build configuration
* Automating repetitive setup tasks

As the platform evolves, this directory allows provisioning logic to remain modular instead of accumulating in the Dockerfile.

---

# Development Container Features

BAOBAB uses Dev Container Features wherever practical to install and maintain common development tooling.

Current Features include:

| Feature    | Purpose                                                    |
| ---------- | ---------------------------------------------------------- |
| Python     | Backend development using Django, FastAPI and `uv`         |
| Node.js    | Frontend development with Next.js                          |
| Java       | Android tooling required for Flutter development           |
| Docker CLI | Build and manage local containers                          |
| GitHub CLI | Interact with GitHub from within the development container |

Additional Features may be introduced in future sprints as new platform capabilities are implemented.

---

# Relationship to the Platform

```text
GitHub Codespaces
        │
        ▼
Development Container
        │
        ▼
Docker Compose
        │
        ▼
Platform Services
        ├── Backend (Django)
        ├── AI (FastAPI)
        ├── Frontend (Next.js)
        ├── Mobile (Flutter)
        ├── Worker
        ├── PostgreSQL
        ├── Redis
        └── Mailpit
```

The Development Container provides the development environment.

Docker Compose orchestrates the local platform.

The platform services provide BAOBAB's application functionality.

---

# Rebuilding the Development Container

Whenever `devcontainer.json`, `docker/Dockerfile`, or scripts under `docker/scripts/` are modified, rebuild the development container.

### Visual Studio Code

1. Open the Command Palette.
2. Select **Dev Containers: Rebuild Container**.

### GitHub Codespaces

Rebuild or recreate the Codespace from the repository.

---

# Engineering Principles

The BAOBAB Development Container follows these principles:

* Reproducible development environments
* Infrastructure as Code
* Minimal manual configuration
* Cross-platform compatibility
* Security by default
* Incremental evolution
* Separation of concerns

---

# Related Documentation

* `docs/03-development/`
* `docs/04-devops/`
* `docs/governance/engineering-handbook.md`
* `docs/governance/repository-governance.md`
* `docs/governance/decision-record-process.md`

---

# Ownership

This configuration is maintained by the BAOBAB Engineering Team.

Changes to the development environment should be reviewed through the project's pull request process and, where appropriate, documented through an Architecture Decision Record (ADR).
