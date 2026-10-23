FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/ubuntu
ENV OPENCODE_CONFIG_DIR=/home/ubuntu/.config/opencode
ENV OPENCODE_DISABLE_AUTOUPDATE=true
ENV PATH=/home/ubuntu/.local/bin:/home/ubuntu/go/bin:/usr/local/bin:/usr/bin:/bin

ARG OPENCODE_VERSION=1.19.2

# setup task repository
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl \
  && curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.deb.sh' | bash

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  clang \
  clangd \
  cmake \
  fd-find \
  file \
  g++ \
  gcc \
  git \
  golang-go \
  jq \
  less \
  make \
  nano \
  ninja-build \
  nodejs \
  npm \
  openssh-client \
  pkg-config \
  procps \
  python3 \
  python3-pip \
  python3-venv \
  ripgrep \
  task \
  unzip \
  vim \
  xz-utils \
  zip \
  && npm install -g opencode-ai@${OPENCODE_VERSION} \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN id ubuntu \
  && mkdir -p /workspace "${OPENCODE_CONFIG_DIR}" \
  && chown -R ubuntu:ubuntu /workspace /home/ubuntu

RUN printf '%s\n' \
  '{' \
  '  "$schema": "https://opencode.ai/config.json",' \
  '  "autoupdate": false,' \
  '  "permission": "allow"' \
  '}' \
  > "${OPENCODE_CONFIG_DIR}/opencode.jsonc" \
  && chown ubuntu:ubuntu "${OPENCODE_CONFIG_DIR}/opencode.jsonc"

WORKDIR /workspace

USER ubuntu

CMD ["opencode"]
