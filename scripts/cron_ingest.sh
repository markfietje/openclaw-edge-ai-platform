#!/bin/bash
# Cron-based brain ingest - runs every minute
# Simpler and more reliable than watchdog

cd /home/jetson/.openclaw/workspace

# Track last processed size
STATE_FILE="/tmp/brain_ingest_state.txt"
LAST_SIZE=0

if [ -f "$STATE_FILE" ]; then
    LAST_SIZE=$(cat "$STATE_FILE")
fi

# Get current size
CURRENT_SIZE=$(wc -c < MEMORY.md)

# Only process if file grew
if [ "$CURRENT_SIZE" -gt "$LAST_SIZE" ]; then
    echo "🧠 New content detected ($(($CURRENT_SIZE - $LAST_SIZE)) bytes)"
    
    # Extract new content
    tail -c $(($CURRENT_SIZE - $LAST_SIZE)) MEMORY.md > /tmp/new_memory.txt
    
    # Ingest new content
    python3 -c "
import sys
sys.path.insert(0, '.')
from knowledge_base_v2 import Brain

brain = Brain()
brain.init_db()

with open('/tmp/new_memory.txt', 'r') as f:
    content = f.read()

# Add to brain
brain.add_knowledge(
    content=content,
    title='Auto-ingested memory log',
    knowledge_type='memory_log',
    source='auto_ingest',
    confidence='high'
)

print('✅ Ingested new memory')
"

    # Update state
    echo "$CURRENT_SIZE" > "$STATE_FILE"
    
    # Keep MEMORY.md from growing (archive if >100KB)
    if [ "$CURRENT_SIZE" -gt 102400 ]; then
        # Keep last 500 lines
        tail -500 MEMORY.md > MEMORY.md.tmp
        mv MEMORY.md.tmp MEMORY.md
        echo "📦 Archived old content (kept last 500 lines)"
    fi
fi
