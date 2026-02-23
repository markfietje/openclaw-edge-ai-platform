# Professional Release Guide

This document explains the professional release workflow for Jetson OpenClaw Setup.

## 🚀 Release Process

### Automated Releases

Releases are **fully automated** via GitHub Actions. When you push a version tag:

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

GitHub Actions will:

1. **Build ARM64 binaries** for Jetson Nano
   - Brain Server (optimized with LTO, opt-level=3)
   - Signal Gateway (standard release build)

2. **Create release packages**
   - `brain-server-arm64.tar.gz`
   - `signal-gateway-arm64.tar.gz`
   - `SHA256SUMS.txt` (checksums for verification)

3. **Generate release notes**
   - Download links for binaries
   - Installation instructions
   - Changelog (commits since last tag)

4. **Publish GitHub release**
   - Attach binaries as release assets
   - Publish with proper versioning
   - Notify watchers

## 📦 Release Assets

Each release includes:

### Binaries
- **brain-server-arm64.tar.gz** - Pre-compiled for ARM64 (Jetson Nano, Raspberry Pi 4+)
- **signal-gateway-arm64.tar.gz** - Pre-compiled for ARM64

### Checksums
- **SHA256SUMS.txt** - SHA256 hashes for verification

### Documentation
- Release notes with installation instructions
- Changelog (what changed)
- Download links

## 📋 Installation from Release

### Method 1: Deployment Script (Recommended)

```bash
# Download and run deployment script
wget https://raw.githubusercontent.com/markfietje/jetson-openclaw-setup/main/scripts/deploy-from-release.sh
chmod +x deploy-from-release.sh
sudo ./deploy-from-release.sh [version]

# Or for latest version
sudo ./deploy-from-release.sh
```

The script will:
- Download binaries for your architecture
- Verify checksums
- Stop services
- Install binaries to `/usr/local/bin`
- Restart services

### Method 2: Manual Installation

```bash
# Download binaries
wget https://github.com/markfietje/jetson-openclaw-setup/releases/download/v1.0.0/brain-server-arm64.tar.gz
wget https://github.com/markfietje/jetson-openclaw-setup/releases/download/v1.0.0/signal-gateway-arm64.tar.gz
wget https://github.com/markfietje/jetson-openclaw-setup/releases/download/v1.0.0/SHA256SUMS.txt

# Verify checksums
sha256sum -c SHA256SUMS.txt

# Extract
tar xzf brain-server-arm64.tar.gz
tar xzf signal-gateway-arm64.tar.gz

# Install
sudo cp brain-server /usr/local/bin/
sudo cp signal-gateway /usr/local/bin/

# Restart services
sudo systemctl restart brain-server signal-gateway
```

## 🏷️ Versioning

This project uses [Semantic Versioning](https://semver.org/):

- **MAJOR** (v1.0.0 → v2.0.0): Breaking changes
- **MINOR** (v1.0.0 → v1.1.0): New features, backward compatible
- **PATCH** (v1.0.0 → v1.0.1): Bug fixes, backward compatible

### When to Release

**MAJOR releases:**
- API breaking changes
- Database schema changes
- Removed features
- Major refactors

**MINOR releases:**
- New features
- New endpoints
- Performance improvements
- Optional new functionality

**PATCH releases:**
- Bug fixes
- Security patches
- Minor improvements
- Documentation updates

## 📊 Release Checklist

Before creating a release:

- [ ] All tests passing (CI green)
- [ ] Code reviewed
- [ ] CHANGELOG.md updated
- [ ] Version bumped in Cargo.toml (if needed)
- [ ] Documentation updated
- [ ] Security audit passed
- [ ] Tested on Jetson Nano

## 🔧 Branch Strategy

```
main (protected)
  └── dev (integration)
       ├── feature/brain-server-knowledge-graph
       ├── feature/signal-gateway-retry
       └── fix/typo-in-readme
```

### Workflow

1. Create feature branch from `dev`
2. Make changes and test locally
3. Push and create PR to `dev`
4. CI runs tests and quality checks
5. Review and merge to `dev`
6. Test integration on `dev`
7. Create PR from `dev` to `main`
8. Final review and merge to `main`
9. Tag release on `main`

## 🎯 Monorepo vs Multi-Repo

### Why Monorepo? ✅

**For this project, monorepo is optimal:**

1. **Tight coupling** - Services depend on each other
2. **Atomic releases** - One version = working stack
3. **Simpler CI/CD** - 6 workflows, not 18
4. **Easier coordination** - Cross-service changes in one PR
5. **Single source of truth** - Shared configs, scripts
6. **Better for solo development** - One person, one repo

**Example:**
- Update Signal Gateway API → Update OpenClaw config → Test together
- Single PR, single CI run, single release

### When to Use Multi-Repo?

Multi-repo is better for:
- Different teams per service
- Independent release cycles
- Different deployment targets
- Large teams with many contributors

**For you:** Monorepo is perfect! ✅

## 📈 Professional Features

### Automated Testing
- ✅ Unit tests on every push
- ✅ Integration tests on PRs
- ✅ Code quality checks (fmt, clippy)
- ✅ Security audits

### Automated Building
- ✅ ARM64 cross-compilation
- ✅ Optimized builds (LTO, opt-level=3)
- ✅ Binary packaging
- ✅ Checksum generation

### Automated Releasing
- ✅ Semantic versioning
- ✅ Changelog generation
- ✅ Release notes
- ✅ Binary attachments
- ✅ GitHub release creation

### Deployment Ready
- ✅ One-command installation
- ✅ Checksum verification
- ✅ Service management
- ✅ Upgrade scripts

## 🔄 Release Workflow Example

```bash
# 1. Make changes
git checkout -b feature/new-feature
# ... work ...
git add .
git commit -m "feat: Add new feature"

# 2. Push and create PR
git push origin feature/new-feature
# Create PR on GitHub

# 3. After merge, create release
git checkout main
git pull
git tag -a v1.1.0 -m "Release v1.1.0: Add new feature"
git push origin v1.1.0

# 4. GitHub Actions creates release automatically
# - Builds binaries
# - Generates checksums
# - Creates GitHub release
# - Publishes assets

# 5. Users can now install
# On Jetson:
sudo ./scripts/deploy-from-release.sh v1.1.0
```

## 📝 Post-Release

After a release:

1. **Verify** installation on Jetson
2. **Monitor** logs for issues
3. **Update** documentation if needed
4. **Announce** to users (if applicable)
5. **Start** next iteration

## 🔗 Links

- [Latest Release](https://github.com/markfietje/jetson-openclaw-setup/releases/latest)
- [All Releases](https://github.com/markfietje/jetson-openclaw-setup/releases)
- [CHANGELOG](https://github.com/markfietje/jetson-openclaw-setup/blob/main/CHANGELOG.md)
- [CI/CD Status](https://github.com/markfietje/jetson-openclaw-setup/actions)
