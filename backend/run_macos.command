#!/usr/bin/env bash
# Двойной клик по этому файлу в Finder запускает IziBox в Terminal.
DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$DIR/run_macos.sh"
