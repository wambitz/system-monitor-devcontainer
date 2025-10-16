#!/usr/bin/env bash
set -e

# ------------------------------------------------------------------------------
# Run the prebuilt system-monitor-dev Docker image interactively
# Passes host UID/GID for runtime remapping (matches DevContainer behavior)
# ------------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
PROJECT_NAME="system-monitor-devcontainer"
IMAGE_NAME="system-monitor-dev:latest"

# ------------------------------------------------------------------------------
# Ensure image exists
# ------------------------------------------------------------------------------
if ! docker image inspect "$IMAGE_NAME" &> /dev/null; then
    echo "[INFO] Image '$IMAGE_NAME' not found. Building it first..."
    "${SCRIPT_DIR}/build_image.sh"
fi

# ------------------------------------------------------------------------------
# Run the container with DevContainer-compatible settings
# Pass HOST_UID and HOST_GID for runtime remapping
# ------------------------------------------------------------------------------
docker run --rm -it \
    --hostname system-monitor-devcontainer \
    --name "system-monitor-dev-${USER}" \
    --env "HOST_UID=$(id -u)" \
    --env "HOST_GID=$(id -g)" \
    --volume "$PROJECT_ROOT:/workspaces/$PROJECT_NAME" \
    --workdir /workspaces/$PROJECT_NAME \
    "$IMAGE_NAME"
