#! /usr/bin/env bash

set -uo pipefail

update() {
  echo "update $*"
  if nix run nixpkgs#nix-update -- --flake --print-commit-message --commit "$@"; then
    echo "✅ ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  else
    echo "⚠️  Failed to update, continuing..."
  fi
  echo
}

# --version=unstable allows tags with -alpha, -beta, -rc suffix or similar
# --version=branch uses the latest commit of the default branch
# you can also do --version=branch=BRANCH_NAME to use a different branch

update helixPlugins.eval
update helixPlugins.extend-sibling
update helixPlugins.glyph
update helixPlugins.http
update helixPlugins.http2curl
update helixPlugins.insert-literal
update helixPlugins.paredit
update helixPlugins.repl-ui
update helixPlugins.run-command
update helixPlugins.scooter
update helixPlugins.scopeline
update helixPlugins.select-ts
update helixPlugins.ts-utils
update helixPlugins.ui-utils
update --version=branch helixPlugins.anchor
update --version=branch helixPlugins.breadcrumbs
update --version=branch helixPlugins.context
update --version=branch helixPlugins.fake-warp
update --version=branch helixPlugins.file-tree-hx
update --version=branch helixPlugins.flash
update --version=branch helixPlugins.forest
update --version=branch helixPlugins.helix-file-watcher
update --version=branch helixPlugins.hetex
update --version=branch helixPlugins.hx-tmux-navigator
update --version=branch helixPlugins.hxwiki
update --version=branch helixPlugins.microscope
update --version=branch helixPlugins.modeline
# update --version=branch helixPlugins.moka # [todo] update again after https://github.com/mattwparas/helix/pull/129 is merged
update --version=branch helixPlugins.notify
update --version=branch helixPlugins.oil
update --version=branch helixPlugins.show-keys
update --version=branch helixPlugins.smooth-scroll
update --version=branch helixPlugins.splash-hx
update --version=branch helixPlugins.steel-pty
update --version=branch helixPlugins.streal
update --version=branch helixPlugins.switch
update --version=branch helixPlugins.switcheroo
update --version=branch helixPlugins.trail
update --version=branch helixPlugins.vim
update --version=branch helixPlugins.wakatime
update --version=branch helixPlugins.who
update --version=branch helixPlugins.zen-mode
update --version=unstable helixPlugins.juju # unstable because the tag has -alpha suffix
