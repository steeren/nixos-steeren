#!/usr/bin/env bash

set -e

UPDATE=false

# Parse arguments
for arg in "$@"; do
  if [[ "$arg" == "--update" ]]; then
    UPDATE=true
  else
    FLAKE="$arg"
  fi
done

if [ -z "$FLAKE" ]; then
  echo "Usage: $0 [--update] <flake>"
  exit 1
fi

if $UPDATE; then
  echo "Updating flake..."
  sudo nix flake update
fi

echo "Rebuilding NixOS configuration..."
sudo nixos-rebuild switch --flake "$FLAKE"