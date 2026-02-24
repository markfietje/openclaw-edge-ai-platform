---
name: zeroclaw
description: "Use ZeroClaw for lightweight AI tasks. Use when: (1) Fast queries, (2) CLI-only tasks, or (3) Minimal resource tasks."
---

# ZeroClaw Skill

ZeroClaw is a lightweight Rust-based AI agent that runs on the Jetson Nano.

## When to use

- Fast, lightweight queries
- CLI-based tasks
- Tasks requiring minimal resources
- Running on ARM64 hardware

## Commands

### zeroclaw_agent

Run a single message through ZeroClaw.

```bash
~/.local/bin/zeroclaw agent -m "Your message here"
```

### zeroclaw_stats

Check ZeroClaw status.

```bash
~/.local/bin/zeroclaw status
```

### zeroclaw_search

Search memory using brain-server.

```bash
curl -s "http://127.0.0.1:8765/search?q=YOUR_QUERY&top_k=5"
```

## Integration

ZeroClaw is connected to:
- brain-server on port 8765 (semantic memory)
- Gateway on port 8080 (webhook API)
- Uses zai/glm-4.7 model
