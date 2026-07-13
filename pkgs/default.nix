{ lib, newScope }:
lib.makeScope newScope (self: {
  buildHelixPlugin = self.callPackage ./buildHelixPlugin.nix { };
  buildHelixPluginWithNative = self.callPackage ./buildHelixPluginWithNative.nix { };

  anchor = self.callPackage ./anchor.nix { };
  fake-warp = self.callPackage ./fake-warp.nix { };
  file-tree-hx = self.callPackage ./file-tree-hx.nix { };
  flash = self.callPackage ./flash.nix { };
  forest = self.callPackage ./forest.nix { };
  glyph = self.callPackage ./glyph.nix { };
  helix-file-watcher = self.callPackage ./helix-file-watcher.nix { };
  hetex = self.callPackage ./hetex.nix { };
  hx-tmux-navigator = self.callPackage ./hx-tmux-navigator.nix { };
  hxwiki = self.callPackage ./hxwiki.nix { };
  juju = self.callPackage ./juju.nix { };
  microscope = self.callPackage ./microscope.nix { };
  modeline = self.callPackage ./modeline.nix { };
  notify = self.callPackage ./notify.nix { };
  oil = self.callPackage ./oil.nix { };
  run-command = self.callPackage ./run-command.nix { };
  scooter = self.callPackage ./scooter.nix { };
  show-keys = self.callPackage ./show-keys.nix { };
  smooth-scroll = self.callPackage ./smooth-scroll.nix { };
  splash-hx = self.callPackage ./splash-hx.nix { };
  steel-pty = self.callPackage ./steel-pty.nix { };
  streal = self.callPackage ./streal.nix { };
  switcheroo = self.callPackage ./switcheroo.nix { };
  trail = self.callPackage ./trail.nix { };
  ui-utils = self.callPackage ./ui-utils.nix { };
  wakatime = self.callPackage ./wakatime.nix { };
  zen-mode = self.callPackage ./zen-mode.nix { };
})
