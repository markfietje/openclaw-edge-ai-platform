#!/bin/bash
set -e

echo "🧪 Running tests inside Linux container..."
echo ""

# Install protobuf compiler
echo "📦 Installing protobuf compiler..."
apt-get update -qq
apt-get install -y -qq protobuf-compiler
echo "✅ Protobuf installed"
echo ""

# Test brain-server
echo "🧠 Testing brain-server..."
cd /workspace/services/brain-server
cargo test --release
cargo clippy -- -D warnings
cargo fmt -- --check
echo "✅ brain-server tests passed"
echo ""

# Test signal-gateway
echo "📡 Testing signal-gateway..."
cd /workspace/services/signal-gateway
cargo test --release
cargo clippy -- -D warnings
cargo fmt -- --check
echo "✅ signal-gateway tests passed"
echo ""

echo "✅ All tests passed!"
echo "✅ Code quality checks passed!"
