#!/bin/bash
# Kenneth H
#

# Default Values
ARCH="amd64"
BUILD_BY="John Doe"
BUILD_COMMENT="some comment"
BUILD_TYPE="release"
CUSTOM_MINISIGN=false # Value is either true or false
MINISIGN_FILE="minisign.pub"
VERSION="1.3.4"
PKG="git neovim"

# if .env file is present, override values of the variables above
if [ -f ".env" ]; then
  source .env
fi

# 1. Copy File to data/live-build-config/hooks/live/
#curl -fsSL https://raw.githubusercontent.com/kholmqvist/vyos-tailscale/main/88-tailscale.chroot -o ../data/live-build-config/hooks/live/88-tailscale.chroot 
curl -fsSL https://raw.githubusercontent.com/kholmqvist/vyos-cloudflared/main/89-cloudflare.chroot -o ../data/live-build-config/hooks/live/89-cloudflare.chroot 

# 1.1 Add custom minisign key
if [ "${CUSTOM_MINISIGN}" == "true" ]; then
  cp -f "${MINISIGN_FILE}" ../data/live-build-config/includes.chroot/usr/share/vyos/keys/vyos-release.minisign.pub
fi

# 1.2 Change diretory to parent
cd ../

# 2. Configure VyOS 1.3
if [ -f "configure" ]; then
  ./configure \
    --architecture "${ARCH}" \
    --build-by "${BUILD_BY}" \
    --build-type "${BUILD_TYPE}" \
    --build-comment "${BUILD_COMMENT}" \
    --custom-package "${PKG}" \
    --version "${VERSION}"
  sudo make iso
fi

# 2. Configure VyOS 1.4
if [ -f "build-vyos-image" ]; then
  sudo ./build-vyos-image iso \
    --architecture "${ARCH}" \
    --build-by "${BUILD_BY}" \
    --build-type "${BUILD_TYPE}" \
    --build-comment "${BUILD_COMMENT}" \
    --custom-apt-entry "deb https://pkgs.tailscale.com/stable/debian bookworm main" \
    --custom-apt-key "/vyos/vyos-custom-build/tailscale.asc" \
    --custom-package "tailscale" \
    --custom-package "${PKG}" \
    --version "${VERSION}"
fi
