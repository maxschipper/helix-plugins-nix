#!/usr/bin/env -S nix shell nixpkgs#jq nixpkgs#nix-update --command bash

# shellcheck shell=bash
# -*- mode: bash -*-

set -uo pipefail


system=$(nix eval --raw --impure --expr 'builtins.currentSystem')

echo "Evaluating plugin updateVersions..."
versions_json=$(nix eval --json ".#legacyPackages.${system}.helixPlugins" --apply '
  plugins:
  builtins.mapAttrs (n: v:
    if (builtins.tryEval v).success && (v.type or "") == "derivation"
    then v.passthru.updateVersion or "stable"
    else null
  ) plugins
' | jq 'with_entries(select(.value != null))')

msg_file=$(mktemp)
trap 'rm -f "$msg_file"' EXIT

if [ $# -gt 0 ]; then
  targets=("$@")
else
  readarray -t targets < <(echo "$versions_json" | jq -r 'keys[]')
fi

for plugin in "${targets[@]}"; do
  version=$(echo "$versions_json" | jq -r ".\"$plugin\" // empty")

  if [ -z "$version" ]; then
    echo "⚠️  Package '$plugin' not found"
    continue
  fi

  if [[ "$version" == "skip" ]]; then
    echo "⏭️  Skipping $plugin (marked as 'skip')"
    echo
    continue
  fi   

  echo "Updating $plugin with version=$version"

  args=("--flake"
        "legacyPackages.${system}.helixPlugins.${plugin}"
        "--version=$version"
        "--print-commit-message"
        # "--commit" # using --write-commit-message instead to remove legacyPackages prefix
        "--write-commit-message=$msg_file"
        )

  # clear msg_file before each update
  : > "$msg_file"

  if nix-update "${args[@]}"; then
    if [ -s "$msg_file" ]; then
      msg=$(< "$msg_file")

      # strip legacyPackages.${system}.helixPlugins.
      clean_msg="${msg/legacyPackages.${system}.helixPlugins./}"

      git commit "pkgs/helixPlugins/${plugin}.nix" -m "$clean_msg"

      echo "✅: $clean_msg"
    else
      echo "✅ Already up to date."
    fi
  else
    echo "⚠️  Failed to update $plugin, continuing..."
  fi
  echo
done
