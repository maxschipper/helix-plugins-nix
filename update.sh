#!/usr/bin/env -S nix shell nixpkgs#nix-update --command bash

# shellcheck shell=bash
# -*- mode: bash -*-

# run `./update.sh` from the repos root to update all packages
# according to their updateVersion (passthru.updateVersion)
# this gets passed to nix-update --version=$updateVersion

# you can also run `./update.sh PKG_NAME` to update only a specific package

set -uo pipefail

system=$(nix eval --raw --impure --expr 'builtins.currentSystem')

if [ $# -gt 0 ]; then
  targets=("$@")
else
  readarray -t targets < <(find pkgs/helixPlugins -maxdepth 1 -name "*.nix" -exec basename {} .nix \; | sort)
fi

plugins_updated=0

for plugin in "${targets[@]}"; do
  echo "Evaluating version for $plugin..."
  
  # Fetch the specific updateVersion, defaulting to "stable" if not set
  version=$(nix eval --raw ".#packages.${system}.${plugin}.passthru.updateVersion")
  # version=$(nix eval --raw ".#packages.${system}.${plugin}.passthru.updateVersion" 2>/dev/null || true)
  # if [ -z "$version" ]; then
  #   version="stable" # nix-update default when not specifying --version
  # fi

  if [[ "$version" == "skip" ]]; then
    echo "[INFO]:  Skipping $plugin (passthru.updateVersion == 'skip')"
    echo
    continue
  fi   

  echo "Updating $plugin with version=$version"

  args=("--flake"
        "${plugin}"
        "--version=$version"
        "--commit"
        )

  old_head=$(git rev-parse HEAD)

  if nix-update "${args[@]}"; then
    if [ "$(git rev-parse HEAD)" != "$old_head" ]; then
      plugins_updated=$((plugins_updated+1))
      echo "[INFO]: Finished updating $plugin"
    else
      echo "No update found"
    fi
  else
    echo "[ERROR]: Failed to update $plugin, continuing..."
  fi
  echo
done

echo -e "Updated $plugins_updated plugin(s)\n\n"
