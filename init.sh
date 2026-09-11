#!/usr/bin/env bash

packages=(
'socat'
)

for package in "${packages[@]}"; do
	sudo pacman -S $package
done
