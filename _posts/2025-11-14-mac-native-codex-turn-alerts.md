---
title: "Mac-Native Codex Turn Alerts"
date: 2025-11-14
summary: "Build a tiny notifier so every Codex turn triggers a macOS banner and optional chime."
tags:
  - codex
  - automation
  - macos
categories:
  - lab-notes
author: evan_oman
agent_focus: workflow
toc: true
---

Codex lets you wire up a `notify` command so every `agent-turn-complete` event can trigger something on your Mac—exactly what the docs describe around the `notify` option in the config file.[^1] Here’s the minimal setup that gives me Notification Center banners plus a chime without installing extra global tools.

## 1. Point Codex at a script

In `~/.codex/config.toml`, add:

```toml
notify = ["uv", "run", "--script", "/Users/<you>/.codex/notify.py"]
```

Codex now calls the script for each turn, and `uv` honors the script’s inline metadata so dependencies come along automatically.

## 2. Script the notification

`~/.codex/notify.py` (make it executable) keeps the banner focused on the repo you’re running and a simple “waiting” status, then plays a system sound with `afplay`. Environment variables control which sound (or none) you hear.

```python
#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
import json, os, subprocess, sys, textwrap
from pathlib import Path

# payload parsing helpers omitted for brevity

def main(argv):
    payload = json.loads(argv[1])

    cwd_label = Path(payload.get("cwd") or "").name or "Codex"
    turn = payload.get("turn-id")
    pieces = [cwd_label]
    if turn:
        pieces.append(f"turn {turn}")
    title = " · ".join(pieces)

    last = payload.get("last-assistant-message") or "Turn complete"
    subtitle = textwrap.shorten(last, width=80)
    body = "Waiting for input…"

    sound = os.environ.get("CODEX_NOTIFY_SOUND_NAME", "Glass")

    script = f'display notification "{body}" with title "{title}" subtitle "{subtitle}"'
    if sound not in {"off", "none", "mute"}:
        script += f' sound name "{sound}"'
    subprocess.run(["osascript", "-e", script])

    if sound not in {"off", "none", "mute"}:
        subprocess.Popen(["afplay", f"/System/Library/Sounds/{sound}.aiff"])
```

## 3. Test once

Execute a dry run:

```bash
CODEX_NOTIFY_SOUND_NAME=Glass uv run --script ~/.codex/notify.py '{"type":"agent-turn-complete","thread-id":"demo","turn-id":"1","cwd":"/Users/you/project","input-messages":["Checking"],"last-assistant-message":"Done"}'
```

You should see the banner and hear a chime. From then on, every Codex chat turn on that Mac lights up Notification Center—even if the terminal’s in the background.

[^1]: https://github.com/openai/codex/blob/547be54ee87592c4d278cb2e9c03ba09913e8164/docs/config.md?plain=1#L649
