# ------------------------------------------------------------------------------
# BAOBAB Development Container
#
# This Dockerfile defines the development environment used by
# GitHub Codespaces and Visual Studio Code Dev Containers.
#
# It is NOT intended for application deployment.
# Application services are containerised separately using Docker Compose.
# ------------------------------------------------------------------------------

FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04 AS development

# ------------------------------------------------------------------------------
# Image Metadata
# ------------------------------------------------------------------------------

LABEL org.opencontainers.image.title="BAOBAB Development Environment"
LABEL org.opencontainers.image.description="Development container for the BAOBAB Enterprise Platform."
LABEL org.opencontainers.image.vendor="NABHOLD Group Africa"
LABEL org.opencontainers.image.authors="BAOBAB Engineering Team"
LABEL org.opencontainers.image.licenses="Apache-2.0"

# ------------------------------------------------------------------------------
# Environment
# ------------------------------------------------------------------------------

ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------------------------------------
# Working Directory
# ------------------------------------------------------------------------------

WORKDIR /workspaces/baobab

# ------------------------------------------------------------------------------
# Default Shell
# ------------------------------------------------------------------------------

SHELL ["/bin/bash", "-c"]

# ------------------------------------------------------------------------------
# Container Entry Point
#
# Keep the container running so that GitHub Codespaces and
# Visual Studio Code can attach to it.
# ------------------------------------------------------------------------------

CMD ["sleep", "infinity"]
