# ==============================================================================
# BAOBAB Development Container
#
# Purpose:
#   Development environment for GitHub Codespaces and VS Code Dev Containers.
#
# This image is NOT used for production deployments.
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

# ------------------------------------------------------------------------------
# Install common development utilities
# ------------------------------------------------------------------------------

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        build-essential \
        ca-certificates \
        curl \
        git \
        jq \
        less \
        nano \
        openssh-client \
        pkg-config \
        software-properties-common \
        sudo \
        tree \
        unzip \
        vim \
        wget \
        zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------------------------
# Working Directory
# ------------------------------------------------------------------------------

WORKDIR /workspaces/baobab

# ------------------------------------------------------------------------------
# Default Shell
# ------------------------------------------------------------------------------

SHELL ["/bin/bash", "-c"]

# ------------------------------------------------------------------------------
# Default Command
# ------------------------------------------------------------------------------

CMD ["sleep", "infinity"]
