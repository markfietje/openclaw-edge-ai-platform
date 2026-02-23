# Development Workflow - MacBook-First

## CRITICAL CONSTRAINT

ALL development MUST happen on MacBook. Jetson is RUNTIME ONLY.

---

## Development Flow

MacBook (dev) → git push → GitHub → Jetson (runtime/deploy)

### Responsibilities

MacBook: Development - Edit code, Commit, Push, Create releases
GitHub: Backup/Version Control - Store history, CI/CD, Releases  
Jetson: Runtime - Run services, Deploy from releases, NO editing

---

## What I CANNOT Do on Jetson

- Edit source code (brain-rs, signal-gateway)
- Modify scripts directly
- Edit workspace files (MEMORY.md, config.yaml, etc.)
- Make commits to git
- Push changes to GitHub

## What I CAN Do on Jetson

- Read files for reference (cat, grep, etc.)
- Check service status (systemctl, curl health endpoints)
- Run commands (start/stop services, monitor logs)
- Deploy from release artifacts
- Test functionality
- Monitor performance

---

## Correct Workflow

### 1. Making Changes (ON MACBOOK ONLY)

cd ~/Sites/jetson-openclaw-setup
vim services/brain-server/src/main.rs
cargo test
git add .
git commit -m "feat: New feature"
git push origin main

### 2. Deploying to Jetson

# ON MACBOOK - Create release tag
git tag -a v1.1.0 -m "Release v1.1.0"
git push origin v1.1.0

# GitHub Actions automatically builds ARM64 binaries

# ON JETSON - Deploy from release
wget https://github.com/markfietje/jetson-openclaw-setup/releases/download/v1.1.0/deploy-from-release.sh
chmod +x deploy-from-release.sh
sudo ./deploy-from-release.sh v1.1.0

---

## Why This Constraint?

1. Single Source of Truth - MacBook has the git repo
2. Proper Git Workflow - Commits happen on MacBook, GitHub is backup
3. Separation of Concerns - MacBook=Dev, Jetson=Production
4. Prevents Errors - No "edit on Jetson, forgot to push" issues

---

## Quick Reference

Edit code: MacBook (vim services/...)
Test code: MacBook (cargo test)
Commit: MacBook (git commit)
Push: MacBook (git push)
Create release: MacBook (git tag && git push)
Check status: Jetson (systemctl status)
View logs: Jetson (journalctl -u)
Deploy: Jetson (./deploy-from-release.sh)
Read config: Either (cat, grep)

---

## Remember

MacBook = Where I work
GitHub = Where code lives  
Jetson = Where code runs
NEVER edit directly on Jetson

---

This workflow is CRITICAL and must be followed in ALL sessions.

Added: 2026-02-23
Status: PERMANENT WORKFLOW CONSTRAINT
