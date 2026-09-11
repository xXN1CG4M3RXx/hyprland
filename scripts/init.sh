#!/usr/bin/env bash

set -euo pipefail

DEP_FILE="${1:-dependencies.txt}"

if [[ ! -f "$DEP_FILE" ]]; then
    echo "Error: File '$DEP_FILE' not found." >&2
    exit 1
fi

# Detect package manager (prefers paru/yay for AUR, falls back to pacman)
if command -v paru &>/dev/null; then
    INSTALL_CMD="paru -S --needed"
elif command -v yay &>/dev/null; then
    INSTALL_CMD="yay -S --needed"
else
    INSTALL_CMD="sudo pacman -S --needed"
fi

missing_pkgs=()

# Read line-by-line, stripping whitespace and comments
while IFS= read -r line || [[ -n "$line" ]]; do
    pkg="$(echo "$line" | sed -e 's/#.*//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    [[ -z "$pkg" ]] && continue

    if pacman -Q "$pkg" &>/dev/null; then
        printf "\e[32m[INSTALLED]\e[0m %s\n" "$pkg"
    else
        printf "\e[31m[MISSING]\e[0m   %s\n" "$pkg"
        missing_pkgs+=("$pkg")
    fi
done < "$DEP_FILE"

if [[ ${#missing_pkgs[@]} -eq 0 ]]; then
    printf "\n\e[32mAll dependencies are satisfied.\e[0m\n"
    exit 0
fi

printf "\nInstalling %d missing package(s): %s\n\n" "${#missing_pkgs[@]}" "${missing_pkgs[*]}"
$INSTALL_CMD "${missing_pkgs[@]}"
