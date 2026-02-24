# Changelog

All notable changes to Jetson OpenClaw Setup will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- GitHub Actions CI/CD workflows for automated testing and deployment
- ARM64 cross-compilation for Jetson Nano deployment
- Automated security audits with cargo-audit
- Dependency tracking and weekly update checks

### Fixed
- **Signal Gateway field name mismatch** - Changed snake_case to camelCase for OpenClaw compatibility
  - Fixed fields: `sourceNumber`, `sourceUuid`, `sourceDevice`, `dataMessage`, `groupInfo`, `contentType`, `groupId`, `groupName`
  - Resolved issue where Signal messages were received but sessions not created
  - Related: [openclaw/openclaw#24490](https://github.com/openclaw/openclaw/issues/24490)

---

## [1.0.0] - 2026-02-23

### Added
- **Monorepo setup** for Jetson AI assistant infrastructure
- **Brain Server v0.8.0** - Knowledge graph + semantic search engine
- **Signal Gateway v0.1.0** - Signal ↔ OpenClaw bridge with auto-retry
- **OpenClaw configuration** for Signal integration (zai/glm-4.7)
- **Systemd services** for automated startup and management
- **Deployment scripts** for easy Jetson updates
- **Comprehensive documentation** (README, API docs, guides)

### Brain Server v0.8.0 Features
- **Knowledge Graph** with entity/relationship extraction
- **1,293 knowledge entries** with 384-dimensional embeddings
- **461 entities + 779 relationships** in the knowledge graph
- **Semantic search** with model2vec-rs (minishlab/potion-retrieval-32M)
- **Graph traversal** with configurable depth (max 3)
- **Annotation syntax** for knowledge mapping
- **Prompt injection detection** for security
- **Connection pooling** with health checks (r2d2)
- **API endpoints**: health, stats, search, ingest/markdown, graph/*

### Signal Gateway v0.1.0 Features
- **Automatic receiver startup** with 5-retry system
- **Exponential backoff** (5s → 10s → 20s → 40s → 80s)
- **Phone number → UUID resolution** with caching
- **HTTP + JSON-RPC API** for sending messages
- **SSE message stream** for real-time receiving
- **Wrapper script** for robust service management
- **Clean shutdown** in 83ms (was 43s hang)
- **Production-ready** systemd integration

### Security
- All services bind to loopback (127.0.0.1)
- No internet exposure
- Fail2Ban enabled for SSH
- Systemd hardening (NoNewPrivileges, ProtectSystem, ProtectHome)
- Prompt injection detection in brain-server
- SQL injection prevention with parameterized queries

### Performance
- **Brain Server**: <1ms per search query, 25% memory usage (1,043MB / 4,156MB)
- **Signal Gateway**: ~10MB memory, 2s startup time, 83ms shutdown
- **Database**: ~10MB compressed SQLite with full-text search

### Documentation
- Comprehensive README with quick start guide
- API reference for all endpoints
- Systemd service management guide
- Deployment and build instructions
- Security audit documentation (A+ rating)

---

## [0.1.0] - 2026-02-19 (Brain Server Alpha)

### Added
- Initial brain-server implementation
- Semantic search with embeddings
- Knowledge extraction from markdown
- Basic API endpoints (health, stats, search)
- SQLite database with r2d2 pooling

### Changed
- Optimized for ARM64 Cortex-A57
- Enabled LTO and size optimization

---

## [0.0.1] - 2026-02-18 (Initial)

### Added
- Project skeleton
- Basic OpenClaw integration
- Signal CLI setup

---

[Unreleased]: https://github.com/markfietje/jetson-openclaw-setup/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/markfietje/jetson-openclaw-setup/releases/tag/v1.0.0
[0.1.0]: https://github.com/markfietje/jetson-openclaw-setup/releases/tag/v0.1.0
[0.0.1]: https://github.com/markfietje/jetson-openclaw-setup/releases/tag/v0.0.1
