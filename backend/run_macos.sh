#!/usr/bin/env bash
# IziBox — запуск на macOS (Apple Silicon).
# Всё необходимое уже в этой папке (включая встроенный Python) —
# устанавливать Python и Node.js не нужно.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 1. Встроенный Python (портативный, лежит в python/)
PYTHON="$SCRIPT_DIR/python/bin/python3.13"

if [ ! -f "$PYTHON" ]; then
    echo "[Ошибка] Не найден встроенный Python: $PYTHON" >&2
    echo "Перекачайте папку backend полностью (должна быть подпапка python/)." >&2
    exit 1
fi
chmod +x "$PYTHON" 2>/dev/null || true

echo "[OK] Python: $("$PYTHON" --version 2>&1)"

# 2. Проверка собранного фронтенда (PWA). Node.js не нужен.
if [ ! -f "../frontend/dist/index.html" ]; then
    echo "[Ошибка] Не найден frontend/dist/index.html" >&2
    exit 1
fi

# 3. Установка зависимостей (выполняется при первом запуске).
echo "Установка зависимостей (первый запуск может занять пару минут)..."
"$PYTHON" -m pip install --quiet --upgrade pip
"$PYTHON" -m pip install --quiet -r requirements.txt -r requirements-macos.txt

# 4. Запуск приложения.
echo "Запуск IziBox — браузер откроется автоматически (http://localhost:7911)."
exec "$PYTHON" run_portable.py
