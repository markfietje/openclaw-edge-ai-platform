# OpenClaw Systemd Services

This directory contains systemd service files for Jetson's AI infrastructure.

## 🧠 Brain Server Services

### brain-server.service
Main knowledge graph and semantic search engine service.
- **Port:** 8765
- **Database:** ~/.brain-server/brain.db
- **Startup:** Automatic (enabled)
- **Status:** Active (running)

### periodic-brain-ingest.service + .timer
Automatically ingests MEMORY.md into brain-server every minute.
- **Trigger:** cron (runs every 60 seconds)
- **Script:** scripts/cron_ingest.sh
- **Purpose:** Keep brain in sync with MEMORY.md changes

### auto-brain-ingest.service
Watches MEMORY.md for changes and auto-updates brain-server.
- **Type:** simple (Python file watcher)
- **Status:** Optional (periodic-brain-ingest is preferred)

## 📡 Signal Gateway Services

### signal-gateway.service
Signal ↔ OpenClaw bridge with automatic receiver startup.
- **Port:** 8080
- **Wrapper:** scripts/signal-gateway-wrapper.sh
- **Features:** Auto-retry (5x), exponential backoff, clean shutdown

## 📋 Installation

```bash
# Copy service files
sudo cp services/openclaw-config/*.service /etc/systemd/system/
sudo cp services/openclaw-config/*.timer /etc/systemd/system/

# Reload systemd
sudo systemctl daemon-reload

# Enable and start services
sudo systemctl enable brain-server.service
sudo systemctl start brain-server.service

sudo systemctl enable periodic-brain-ingest.timer
sudo systemctl start periodic-brain-ingest.timer

sudo systemctl enable signal-gateway.service
sudo systemctl start signal-gateway.service
```

## 🔧 Management

```bash
# Check status
sudo systemctl status brain-server
sudo systemctl status signal-gateway
sudo systemctl status periodic-brain-ingest.timer

# View logs
journalctl -u brain-server -f
journalctl -u signal-gateway -f
journalctl -u periodic-brain-ingest -f

# Restart
sudo systemctl restart brain-server
sudo systemctl restart signal-gateway
```
