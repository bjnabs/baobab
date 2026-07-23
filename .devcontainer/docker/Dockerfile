# ==============================================================================
# BAOBAB Enterprise Platform
#
# Dockerfile : Development Container
#
# Purpose
# -------
# Base image for GitHub Codespaces and VS Code Dev Containers.
#
# Responsibilities
# ----------------
# • Provide a stable Ubuntu development environment.
# • Install common operating system packages.
# • Configure the development container environment.
# • Prepare the workspace.
#
# This image intentionally DOES NOT install language runtimes or project
# dependencies. Those are provisioned by the BAOBAB Provisioning Framework
# under:
#
#     .devcontainer/docker/scripts/
#
# The provisioning sequence is:
#
#     run.sh
#         ├── bootstrap.sh
#         ├── environment.sh
#         ├── install.sh
#         ├── verify.sh
#         └── summary.sh
#
# This image is NOT intended for production deployments.
#
# Author  : BAOBAB Contributors
# License : Apache License 2.0
# ==============================================================================

FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04 AS development

# ------------------------------------------------------------------------------
# Image Metadata
# ------------------------------------------------------------------------------

LABEL org.opencontainers.image.title="BAOBAB Development Environment"
LABEL org.opencontainers.image.description="Development container for the BAOBAB Enterprise Platform."
LABEL org.opencontainers.image.vendor="NabHold Group Africa"
LABEL org.opencontainers.image.authors="BAOBAB Engineering Team"
LABEL org.opencontainers.image.licenses="Apache-2.0"

# ------------------------------------------------------------------------------
# Environment
# ------------------------------------------------------------------------------

ENV DEBIAN_FRONTEND=noninteractive

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TZ=UTC

# ------------------------------------------------------------------------------
# Default Shell
# ------------------------------------------------------------------------------

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# ------------------------------------------------------------------------------
# Install Base Operating System Packages
# ------------------------------------------------------------------------------

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        build-essential \
        ca-certificates \
        curl \
        file \
        git \
        gnupg \
        jq \
        less \
        locales \
        lsb-release \
        nano \
        openssh-client \
        pkg-config \
        procps \
        rsync \
        software-properties-common \
        sudo \
        tar \
        tree \
        unzip \
        vim \
        wget \
        xz-utils \
        zip && \
    locale-gen en_US.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------------------------
# Create Common Development Directories
# ------------------------------------------------------------------------------

RUN mkdir -p \
    /opt/baobab \
    /opt/baobab/cache \
    /opt/baobab/tools \
    /var/log/baobab

# ------------------------------------------------------------------------------
# Workspace
# ------------------------------------------------------------------------------

WORKDIR /workspaces/baobab

# ------------------------------------------------------------------------------
# Container Environment
# ------------------------------------------------------------------------------

ENV BAOBAB_HOME=/workspaces/baobab \
    BAOBAB_ENV=development

# ------------------------------------------------------------------------------
# Default Command
# ------------------------------------------------------------------------------

CMD ["sleep", "infinity"]
