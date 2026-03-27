#!/bin/bash
SKILL_DIR="/home/admin/.openclaw/workspace/skills/why-not-wear-clothes"
STATE_FILE="$SKILL_DIR/data/state/self_improvement.json"

CURRENT_TIME=$(date -Iseconds)
LAST_ROUND=$(jq -r '.current_round' "$STATE_FILE")
NEXT_ROUND=$((LAST_ROUND + 1))

if [[ $NEXT_ROUND -le 12 ]]; then
    jq --arg time "$CURRENT_TIME" --argjson round "$NEXT_ROUND" \
        '.last_check_time = $time | .current_round = $round' "$STATE_FILE" > /tmp/state_tmp.json
    mv /tmp/state_tmp.json "$STATE_FILE"
    echo "Round $NEXT_ROUND triggered at $CURRENT_TIME"
fi
