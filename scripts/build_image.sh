#!/usr/bin/env bash
set -e

###############################################################################
# Build the System Monitor Dev Docker image
#
# This image uses runtime UID/GID remapping for portability.
# No user-specific build args needed - same image works for all users.
#
# Usage:
#   ./scripts/build_image.sh [--tag <image_tag>]
#
# Default image tag: system-monitor-dev:latest
###############################################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DOCKERFILE_PATH="${PROJECT_ROOT}/Dockerfile"

IMAGE_TAG="system-monitor-dev:latest"

# ------------------------------------------------------------------------------
# Build the Docker image
# ------------------------------------------------------------------------------
echo "[INFO] Building Docker image: ${IMAGE_TAG}"
echo "[INFO] Dockerfile: ${DOCKERFILE_PATH}"
echo "[INFO] Using runtime UID/GID remapping (portable image)"

docker build \
  -f "${DOCKERFILE_PATH}" \
  -t "${IMAGE_TAG}" \
  "${PROJECT_ROOT}"

echo "[INFO] Docker image '${IMAGE_TAG}' built successfully."
echo "[INFO] This image will adapt to any user's UID/GID at runtime."
