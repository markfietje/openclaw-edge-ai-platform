#!/bin/bash
# Professional deployment script for Jetson OpenClaw Setup
# Downloads and installs binaries from GitHub releases

set -euo pipefail

# Configuration
REPO="markfietje/jetson-openclaw-setup"
VERSION="${1:-latest}"
INSTALL_DIR="/usr/local/bin"
TEMP_DIR=$(mktemp -d)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*"
}

cleanup() {
    log_info "Cleaning up temporary files..."
    rm -rf "$TEMP_DIR"
}

trap cleanup EXIT

# Check if running on ARM64
ARCH=$(uname -m)
if [ "$ARCH" != "aarch64" ]; then
    log_warn "This script is designed for ARM64 (Jetson Nano). Current architecture: $ARCH"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    log_error "This script must be run as root (use sudo)"
    exit 1
fi

# Get version info
if [ "$VERSION" = "latest" ]; then
    log_info "Fetching latest release info..."
    RELEASE_TAG=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | jq -r '.tag_name')
else
    RELEASE_TAG="$VERSION"
fi

log_info "Installing version: $RELEASE_TAG"
log_info "Repository: ${REPO}"

# Download binaries
cd "$TEMP_DIR"

log_info "Downloading Brain Server..."
wget -q --show-progress "https://github.com/${REPO}/releases/download/${RELEASE_TAG}/brain-server-arm64.tar.gz" || {
    log_error "Failed to download brain-server"
    exit 1
}

log_info "Downloading Signal Gateway..."
wget -q --show-progress "https://github.com/${REPO}/releases/download/${RELEASE_TAG}/signal-gateway-arm64.tar.gz" || {
    log_error "Failed to download signal-gateway"
    exit 1
}

log_info "Downloading checksums..."
wget -q "https://github.com/${REPO}/releases/download/${RELEASE_TAG}/SHA256SUMS.txt" || {
    log_warn "Could not download checksums (continuing anyway)"
}

# Verify checksums if available
if [ -f "SHA256SUMS.txt" ]; then
    log_info "Verifying checksums..."
    if sha256sum -c SHA256SUMS.txt; then
        log_info "Checksum verification passed!"
    else
        log_error "Checksum verification failed!"
        exit 1
    fi
fi

# Stop services
log_info "Stopping services..."
systemctl stop brain-server 2>/dev/null || true
systemctl stop signal-gateway 2>/dev/null || true

# Extract and install
log_info "Extracting binaries..."
tar xzf brain-server-arm64.tar.gz
tar xzf signal-gateway-arm64.tar.gz

log_info "Installing binaries to ${INSTALL_DIR}..."
cp brain-server "${INSTALL_DIR}/"
cp signal-gateway "${INSTALL_DIR}/"
chmod +x "${INSTALL_DIR}/brain-server"
chmod +x "${INSTALL_DIR}/signal-gateway"

log_info "Installing wrapper script..."
# Copy wrapper script if it exists in the repo
wget -q "https://raw.githubusercontent.com/${REPO}/${RELEASE_TAG}/scripts/signal-gateway-wrapper.sh" -O "${INSTALL_DIR}/signal-gateway-wrapper.sh" 2>/dev/null || {
    log_warn "Could not download wrapper script (you may need to install manually)"
}
chmod +x "${INSTALL_DIR}/signal-gateway-wrapper.sh" 2>/dev/null || true

# Restart services
log_info "Restarting services..."
systemctl daemon-reload 2>/dev/null || true
systemctl start brain-server 2>/dev/null || log_warn "brain-server service not configured"
systemctl start signal-gateway 2>/dev/null || log_warn "signal-gateway service not configured"

# Verify installation
log_info "Verifying installation..."
if command -v brain-server &> /dev/null; then
    BRAIN_VERSION=$(brain-server --version 2>&1 || echo "unknown")
    log_info "Brain Server installed: $BRAIN_VERSION"
else
    log_warn "Brain Server not found in PATH"
fi

if command -v signal-gateway &> /dev/null; then
    SIGNAL_VERSION=$(signal-gateway --version 2>&1 || echo "unknown")
    log_info "Signal Gateway installed: $SIGNAL_VERSION"
else
    log_warn "Signal Gateway not found in PATH"
fi

echo ""
log_info "Installation completed successfully!"
echo ""
echo "Next steps:"
echo "  1. Check service status: sudo systemctl status brain-server signal-gateway"
echo "  2. View logs: sudo journalctl -u brain-server -f"
echo "  3. Read docs: https://github.com/${REPO}#readme"
echo ""
