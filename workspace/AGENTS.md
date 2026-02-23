# AGENTS.md

## Agent Identity
- Name: Jetson
- Role: AI Assistant
- Model: zai/glm-4.7
- Version: 2026.2.21.2

## Core Capabilities
- Answer questions and provide information
- Help with tasks and problem-solving
- Memory integration via brain-server
- Context-aware responses

## Workspace
- **Jetson Workspace:** ~/.openclaw/workspace/ (runtime config, MEMORY.md)
- **Development Repo:** ~/openclaw-repo/ (git repo, projects, documentation)
- **Brain-server:** http://127.0.0.1:8765
- **Gateway:** http://127.0.0.1:18789

## Distributed Workflow
- **Jetson Dev:** ~/openclaw-repo/ (AI assistant works here)
- **MacBook Dev:** ~/Sites/jetson-openclaw-setup/ (Mark works here)
- **GitHub:** https://github.com/markfietje/jetson-openclaw-setup (sync & automation)
- **Rule:** ALWAYS `git pull origin main` before making changes
- **Can edit:** Services, scripts, docs, config files directly on Jetson ✅
- **Automated:** Push to GitHub → GitHub Actions builds & deploys to Jetson 🚀

### Git Workflow
1. Pull latest: `cd ~/openclaw-repo/jetson-openclaw-setup && git pull origin main`
2. Make changes
3. Commit: `git add . && git commit -m "feat: description"`
4. Push: `git push origin main`
5. **GitHub Actions automatically builds and deploys!** ✅

### Important Files
- **.rules** - Complete development workflow and deployment commands
- **TODO.md** - GitHub Actions setup status and instructions
- **README.md** - Project overview and service documentation

## Service Endpoints
- **Brain Server:** http://127.0.0.1:8765
  - Health: `curl http://127.0.0.1:8765/health`
  - Stats: `curl http://127.0.0.1:8765/stats | jq .`
  - Search: `curl -X POST http://127.0.0.1:8765/search -H 'Content-Type: application/json' -d '{"query":"test","k":5}' | jq .`
- **Signal Gateway:** http://127.0.0.1:8080
  - Health: `curl http://127.0.0.1:8080/v1/health | jq .`
  - Status: `curl http://127.0.0.1:8080/v1/status | jq .`

## System Commands
- Restart services: `sudo systemctl restart brain-server signal-gateway`
- Check logs: `sudo journalctl -u brain-server -f`
- View workflow: `cat ~/openclaw-repo/jetson-openclaw-setup/.github/workflows/auto-deploy.yml`

## Automated Deployment (GitHub Actions)
When you push to `main` branch:
1. ✅ GitHub builds ARM64 binaries for brain-server & signal-gateway
2. ✅ Uploads to Jetson via SSH
3. ✅ Restarts systemd services automatically
4. ✅ Runs health checks
5. ✅ Reports deployment status

**This means:** After you push changes, updated services deploy within minutes!

## What You Can Edit
✅ **Services:**
- `services/brain-server/src/` - Rust source code
- `services/signal-gateway/src/` - Rust source code

✅ **Scripts:**
- `scripts/*.sh` - Shell scripts

✅ **Documentation:**
- `docs/*.md` - Documentation files
- `services/*/README.md` - Service documentation

✅ **Configuration:**
- `services/*/config/` - Service configs
- `.rules` - Development rules

## Notes
- Keep responses concise
- Use brain-server for memory lookups
- Context limit: 200K tokens
- Session scope: per-sender
- Always pull before pushing to prevent merge conflicts
- Check `.rules` for complete workflow documentation
- Automated deployment enabled via GitHub Actions 🚀
