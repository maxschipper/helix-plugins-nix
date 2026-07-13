#! /usr/bin/env bash

set -uo pipefail

update() {
      echo "Updating $*..."
      if nix run nixpkgs#nix-update -- --flake --print-commit-message --commit "$@"; then
        echo "✅ Successfully updated"
      else
        echo "⚠️  Failed to update, continuing..."
      fi
      echo
  }

update --version=branch=main helixPlugins.forest
update --version=branch=main helixPlugins.glyph
update --version=branch=main helixPlugins.hxwiki
update --version=branch=main helixPlugins.juju
update --version=branch=main helixPlugins.notify
update --version=branch=main helixPlugins.oil
update --version=branch=main helixPlugins.run-command
update --version=branch=main helixPlugins.scooter
update --version=branch=main helixPlugins.smooth-scroll
update --version=branch=main helixPlugins.ui-utils
update --version=branch=master helixPlugins.file-tree-hx
update --version=branch=master helixPlugins.flash
update --version=branch=master helixPlugins.helix-file-watcher
update --version=branch=master helixPlugins.splash-hx
update --version=branch=master helixPlugins.steel-pty
