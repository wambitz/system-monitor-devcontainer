# -----------------------------------------------------------------------------
# Dev Dockerfile for system-monitor
# -----------------------------------------------------------------------------
# This image is intended for local development and testing. Source code is mounted.
# Uses runtime UID/GID remapping for portability across different hosts.
# Leverages Ubuntu 24.04's built-in 'ubuntu' user for simplicity.
# -----------------------------------------------------------------------------

FROM ubuntu:24.04

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# -----------------------------------------------------------------------------
# Install C++ dev tools and project dependencies
# -----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    sudo \
    build-essential \
    cmake \
    git \
    gdb \
    libncurses5-dev \
    libncursesw5-dev \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------------------------
# Configure the existing 'ubuntu' user (UID/GID will be remapped at runtime)
# ------------------------------------------------------------------------------
RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu

# ------------------------------------------------------------------------------
# Configure bash with colors for ubuntu user
# ------------------------------------------------------------------------------
RUN echo 'export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "' >> /home/ubuntu/.bashrc \
    && echo 'alias ls="ls --color=auto"' >> /home/ubuntu/.bashrc \
    && echo 'alias grep="grep --color=auto"' >> /home/ubuntu/.bashrc

# ------------------------------------------------------------------------------
# Copy entrypoint script
# ------------------------------------------------------------------------------
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# ------------------------------------------------------------------------------
# Set working directory
# ------------------------------------------------------------------------------
WORKDIR /workspaces

# ------------------------------------------------------------------------------
# Use entrypoint to handle UID/GID remapping at runtime
# ------------------------------------------------------------------------------
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
