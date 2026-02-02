#!/bin/bash
set -euo pipefail

VAULT="/mnt/d/obsidian-vault/Marckux-Vault"
SPELL="$HOME/.config/nvim/spell/obsidian-es.utf-8.add"
DICT="es_ES"

mkdir -p "$(dirname "$SPELL")"

# -----------------------------
# 1. Extraer palabras candidatas
# -----------------------------
candidates=$(
  find "$VAULT" -name "*.md" -print0 \
  | xargs -0 sed \
      -e '/^```/,/^```/d' \
      -e 's/`[^`]*`//g' \
      -e 's#https\?://[^ ]*##g' \
      -e 's/!\[[^]]*\](\([^)]*\))//g' \
      -e 's/\[[^]]*\](\([^)]*\))//g' \
  | grep -oE '\b[[:alpha:]]{4,}\b' \
  | tr '[:upper:]' '[:lower:]' \
  | sort -u
)

# ---------------------------------------
# 2. Palabras NO válidas según Hunspell
# ---------------------------------------
invalid=$(
  echo "$candidates" \
  | hunspell -d "$DICT" -l \
  | sort -u
)

# ---------------------------------------
# 3. Palabras válidas = candidates - invalid
# ---------------------------------------
valid=$(
  comm -23 \
    <(echo "$candidates") \
    <(echo "$invalid")
)

# ------------------------------------------------
# 4. Añadir solo las nuevas al diccionario personal
# ------------------------------------------------
touch "$SPELL"

comm -13 \
  <(sort -u "$SPELL") \
  <(echo "$valid") \
>> "$SPELL"

# Dejar el diccionario limpio y ordenado
sort -u "$SPELL" -o "$SPELL"

