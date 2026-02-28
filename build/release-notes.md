# 🚀 Release v0.8.6

**Release Date:** 2026-02-28
**Repository:** [jetson-openclaw-setup](https://github.com/markfietje/jetson-openclaw-setup)

---

## 📋 Release Notes

## [0.8.6] - 2026-02-28

### CI/CD
- Fixed release workflow to allow updating existing releases
- Enabled Debian package building in ARM64 release workflow
- Fixed changelog generation script failure

---

## [0.8.5] - 2026-02-26

### Infrastructure
- Fixed debian control files for dpkg-deb compatibility
- Added Version field to control files
- Removed duplicate Maintainer field
- Added libssl3 dependency
- Save deb packages to Jetson instead of auto-deploying

### CI/CD
- Added protobuf-compiler to Pre-Release Tests workflow

---

## [0.8.4] - 2026-02-26

### Infrastructure
- Simplified to ARM64-only builds (Jetson Nano focus)
- All containers now use 4GB memory
- Removed AMD64 builds - users can build from source
- macOS runner is stateless (no local dependencies)
- Added protobuf-compiler to binary build for signal-gateway

### CI/CD
- Skipped pre-release tests in release workflow (already run in CI)
- Uses containers for: binary building, Debian packaging, checksums
- Fixed changelog script to handle ## prefix

---

## [0.8.3] - 2026-02-26

### Infrastructure
- Added Enterprise-Grade workflow names
- Removed "(Enterprise-Grade)" suffix for cleaner naming

---

## [0.8.2] - 2025-02-25

### Infrastructure
#### CI/CD Improvements
- **Switched to Apple Containers** for building Linux binaries
- All workflows now use `apple-container` runner (self-hosted on MacBook Pro M1 Pro)
- ARM64 builds: Native Linux ARM64 containers on Apple Silicon
- AMD64 builds: Linux AMD64 containers with Rosetta emulation
- Eliminated cross-compilation issues with C dependencies

#### Build System
- Building inside official Rust containers (`rust:latest`)
- Full Linux environment for both ARM64 and AMD64 targets
- Proper support for C dependencies (openssl, protobuf, etc.)
- Binary verification and checksums for all builds

### Brain Server
- Optimized builds for ARM64 (Jetson Nano) and AMD64
- Debian packages included for easy installation
- All tests passing

### Signal Gateway
- **Fixed code formatting issues** in signal-gateway/src/api/mod.rs
- Applied cargo fmt for consistent code style
- Zero clippy warnings
- Optimized builds for ARM64 (Jetson Nano) and AMD64
- Debian packages included for easy installation
- All tests passing

### Artifacts
- **brain-server_arm64.deb** - Debian package for Jetson Nano
- **brain-server_amd64.deb** - Debian package for standard Linux
- **signal-gateway_arm64.deb** - Debian package for Jetson Nano
- **signal-gateway_amd64.deb** - Debian package for standard Linux
- Binary tarballs with SHA256 checksums

---

---

- **Commits:** 36
- **Contributors:** 1

---

## 📦 Installation

### Debian Package (Recommended for Jetson Nano)

Download and install the .deb packages:

```bash
# Download packages
wget https://github.com/markfietje/jetson-openclaw-setup/releases/download/v0.8.6/brain-server_0.8.6_arm64.deb
wget https://github.com/markfietje/jetson-openclaw-setup/releases/download/v0.8.6/signal-gateway_0.8.6_arm64.deb

# Install packages
sudo dpkg -i brain-server_0.8.6_arm64.deb
sudo dpkg -i signal-gateway_0.8.6_arm64.deb

# Start services
sudo systemctl start brain-server signal-gateway
sudo systemctl enable brain-server signal-gateway
```

### Binary Installation (Alternative)

```bash
# Download binaries
wget https://github.com/markfietje/jetson-openclaw-setup/releases/download/v0.8.6/brain-server-arm64.tar.gz
wget https://github.com/markfietje/jetson-openclaw-setup/releases/download/v0.8.6/signal-gateway-arm64.tar.gz

# Extract and install
tar xzf brain-server-arm64.tar.gz
tar xzf signal-gateway-arm64.tar.gz
sudo mv brain-server /usr/local/bin/
sudo mv signal-gateway /usr/local/bin/
sudo chmod +x /usr/local/bin/brain-server
sudo chmod +x /usr/local/bin/signal-gateway
```

---

## 🔐 Verification

All release artifacts include SHA256 checksums for verification.

```bash
# Download checksums
wget https://github.com/markfietje/jetson-openclaw-setup/releases/download/v0.8.6/SHA256SUMS.txt

# Verify packages
sha256sum -c SHA256SUMS.txt
```

---

## 📥 Download Links

### Debian Packages (ARM64)

| Package | Size | Download |
|---------|------|----------|
| Brain Server | [`brain-server_0.8.6_arm64.deb`](https://github.com/markfietje/jetson-openclaw-setup/releases/download/v0.8.6/brain-server_0.8.6_arm64.deb) | Direct install with dpkg |
| Signal Gateway | [`signal-gateway_0.8.6_arm64.deb`](https://github.com/markfietje/jetson-openclaw-setup/releases/download/v0.8.6/signal-gateway_0.8.6_arm64.deb) | Direct install with dpkg |

### Binary Archives (ARM64)

| Service | Size | Download |
|---------|------|----------|
| Brain Server | [`brain-server-arm64.tar.gz`](https://github.com/markfietje/jetson-openclaw-setup/releases/download/v0.8.6/brain-server-arm64.tar.gz) | Standalone binary |
| Signal Gateway | [`signal-gateway-arm64.tar.gz`](https://github.com/markfietje/jetson-openclaw-setup/releases/download/v0.8.6/signal-gateway-arm64.tar.gz) | Standalone binary |

### Checksums

- [`SHA256SUMS.txt`](https://github.com/markfietje/jetson-openclaw-setup/releases/download/v0.8.6/SHA256SUMS.txt) - SHA256 checksums for all artifacts

---

## 🔧 Quick Start

After installation:

```bash
# Check service status
sudo systemctl status brain-server signal-gateway

# View logs
sudo journalctl -u brain-server -f
sudo journalctl -u signal-gateway -f

# Test endpoints
curl http://localhost:8765/health
curl http://localhost:8080/v1/health
```

---

## 📚 Documentation

- [README.md](https://github.com/markfietje/jetson-openclaw-setup/blob/v0.8.6/README.md) - Project overview and setup guide
- [API Documentation](https://github.com/markfietje/jetson-openclaw-setup/blob/v0.8.6/docs/API.md) - API endpoints and usage
- [Deployment Guide](https://github.com/markfietje/jetson-openclaw-setup/blob/v0.8.6/docs/DEPLOYMENT.md) - Deployment instructions

---

## 🔄 Upgrade from Previous Version

If upgrading from a previous version:

```bash
# Stop services
sudo systemctl stop brain-server signal-gateway

# Upgrade packages
sudo dpkg -i brain-server_0.8.6_arm64.deb
sudo dpkg -i signal-gateway_0.8.6_arm64.deb

# Start services
sudo systemctl start brain-server signal-gateway

# Verify upgrade
sudo systemctl status brain-server signal-gateway
```

Your configuration and data will be preserved during the upgrade.

---

## 📝 Changelog

For a complete list of changes, see the [CHANGELOG.md](https://github.com/markfietje/jetson-openclaw-setup/blob/v0.8.6/CHANGELOG.md) file.

---

### 💻 Commit History

#### 🐛 Bug Fixes
- fix: use dynamic version in release summary
- fix: allow release workflow to update existing releases
- fix: skip pre-release tests in release workflow
- fix: handle missing artifacts gracefully in release workflow
- fix: remove ARM64 verify build from release workflow
- fix: remove ARM64 build from release workflow (use auto-deploy)
- fix: allow workflow to continue even if tests fail
- fix: allow release creation even if ARM64 build fails
- fix: enable ARM64 build with continue-on-error
- fix: disable ARM64 build in release workflow (use auto-deploy)
- fix: skip ARM64 build in release (built by auto-deploy)
- fix: build ARM64 sequentially in release workflow
- fix: add ARM64 target to Rust toolchain in release workflow
- fix: simplify ARM64 cross-compilation install
- fix: add ARM64 cross-compilation tools to release workflow
- fix: revert to hostname jetson for SSH (mDNS working)
- fix: use IP address instead of hostname for Jetson SSH in workflows
- Fix signal-gateway systemd service to not depend on brain-server system service
- fix: add libssl3 to container for dependency resolution
- fix: add libssl3 dependency to control files
- fix: add missing fi and fix indentation in build script
- fix: remove conffiles reference (file not in package)
- fix: remove duplicate Maintainer field from control files
- fix: replace dpkg substitution variables with concrete deps
- fix: add protobuf-compiler to Pre-Release Tests
- fix: remove blank line in control files
- fix: save deb packages to Jetson instead of deploying
- fix: add Version field to debian control files

#### ⚡ Improvements
- revert: remove libssl3 from container (not needed for build)

#### 📚 Documentation
- docs: add v0.8.6 to changelog
- docs: update repo name and package versions
- docs: rename to OpenClaw Edge AI Platform
- docs: add v0.8.5 to changelog

#### 🔧 Maintenance
- chore: update versions to 0.8.6 and fix signal-gateway dependencies
- chore: clean up CHANGELOG
- chore: clean up CHANGELOG - fix duplicate entries

---

**Full Changelog**: [https://github.com/markfietje/jetson-openclaw-setup/compare/v0.8.4...v0.8.6](https://github.com/markfietje/jetson-openclaw-setup/compare/v0.8.4...v0.8.6)
