# GitHub Actions Workflows

Automated CI/CD for Jetson's AI infrastructure.

## 🔄 Workflows

### CI/Testing

#### brain-server-ci.yml
- Triggers: Push/PR to main/dev, changes in brain-server
- Runs: Format check, clippy, tests, release build
- **NEW:** Now builds ARM64 binaries for Jetson!
- Security audit with cargo-audit

#### signal-gateway-ci.yml
- Triggers: Push/PR to main/dev, changes in signal-gateway
- Runs: Format check, clippy, tests, cross-compilation (ARM64)
- Security audit with cargo-audit

#### code-quality.yml
- Triggers: Push/PR to main/dev
- Runs:
  - Rust formatting checks ()
  - Linting ()
  - YAML validation ()
  - Shell script checks ()
  - Systemd service file validation

## 🔐 GitHub Secrets Setup

**REQUIRED for auto-deployment:** You must set these secrets in GitHub first!

### 1. Generate SSH Key Pair

On your local machine (NOT on Jetson):
```bash
# Generate new SSH key for GitHub Actions
ssh-keygen -t ed25519 -C "github-actions@jetson" -f ~/.ssh/github_actions_jetson

# Copy public key to Jetson
ssh-copy-id -i ~/.ssh/github_actions_jetson.pub jetson@jetson

# Test SSH connection
ssh -i ~/.ssh/github_actions_jetson jetson@jetson "echo 'SSH works!'"
```

### 2. Get SSH Known Hosts Entry

```bash
# Get the Jetson's SSH host key
ssh-keyscan jetson > ~/.ssh/jetson_known_hosts
cat ~/.ssh/jetson_known_hosts
```

### 3. Add Secrets to GitHub

Go to: **Settings → Secrets and variables → Actions → New repository secret**

Add these secrets:
- **Name:** `JETSON_SSH_KEY`
  - **Value:** Contents of `~/.ssh/github_actions_jetson` (the PRIVATE key)
  
- **Name:** `JETSON_SSH_KNOWN_HOSTS`
  - **Value:** Contents of `~/.ssh/jetson_known_hosts`

### Deployment

#### auto-deploy.yml 🚀 NEW!
- Triggers: Push to main (changes in services/, scripts/, or configs)
- **Fully automated:** Builds ARM64 binaries → Deploys to Jetson → Restarts services
- Manual trigger available with service selection
- Includes health checks and verification

**Auto-deploy workflow:**
```bash
git commit -m "feat: Update brain server"
git push
# GitHub automatically builds and deploys to Jetson!
```

#### deploy.yml (Legacy)
- Triggers: Push to main with `[deploy]` in commit message, or manual trigger
- Builds ARM64 binaries for Jetson
- Creates deployment packages
- Uploads artifacts (7-day retention)

### Release

#### release.yml
- Triggers: Git tag push (e.g., )
- Creates GitHub release
- Auto-generates changelog from commits

**To create release:**
```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

### Maintenance

#### dependencies.yml
- Triggers: Every Monday 9:00 AM UTC, or manual
- Checks for outdated dependencies ()
- Runs security audits ()
- Uploads reports as artifacts

## 📦 Artifacts

All workflows upload artifacts with 7-30 day retention:
- Binary releases (ARM64)
- Security audit reports
- Dependency reports
- Deployment packages

Download from: **Actions → Select workflow run → Artifacts section**

## 🔧 Local Testing

Before pushing, test locally:

```bash
# Format check
cd services/brain-server && cargo fmt -- --check
cd services/signal-gateway && cargo fmt -- --check

# Lint
cd services/brain-server && cargo clippy
cd services/signal-gateway && cargo clippy

# Test
cd services/brain-server && cargo test
cd services/signal-gateway && cargo test

# Build for Jetson
cd services/brain-server && cargo build --release --target aarch64-unknown-linux-gnu
cd services/signal-gateway && cargo build --release --target aarch64-unknown-linux-gnu
```

## 🚀 Deployment Methods

### Method 1: Fully Automated (Recommended) ⭐

Just push to main branch - GitHub does everything!

```bash
git commit -m "feat: Amazing new feature"
git push origin main
```

**What happens:**
1. GitHub builds ARM64 binaries for both services
2. Uploads to Jetson via SSH
3. Restarts systemd services automatically
4. Runs health checks
5. Reports deployment status

### Method 2: Manual Trigger

Go to: **Actions → Auto Deploy to Jetson → Run workflow**

Choose which services to deploy (brain-server, signal-gateway, or both).

### Method 3: Legacy Deploy

```bash
git commit -m "feat: New feature [deploy]"
git push
```

Download artifacts manually from GitHub Actions → Artifacts section.

## 📊 Status Badges

Add to README.md:

```markdown
![Brain Server CI](https://github.com/markfietje/jetson-openclaw-setup/workflows/Brain%20Server%20CI/badge.svg)
![Signal Gateway CI](https://github.com/markfietje/jetson-openclaw-setup/workflows/Signal%20Gateway%20CI/badge.svg)
![Code Quality](https://github.com/markfietje/jetson-openclaw-setup/workflows/Code%20Quality/badge.svg)
```
