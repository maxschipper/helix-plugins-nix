{ lib, newScope }:
lib.makeScope newScope (self: {
  buildHelixPlugin = self.callPackage ./buildHelixPlugin.nix { };
  buildHelixPluginWithNative = self.callPackage ./buildHelixPluginWithNative.nix { };

  file-tree-hx = self.callPackage ./file-tree-hx.nix { };
  flash = self.callPackage ./flash.nix { };
  forest = self.callPackage ./forest.nix { };
  glyph = self.callPackage ./glyph.nix { };
  helix-file-watcher = self.callPackage ./helix-file-watcher.nix { };
  juju = self.callPackage ./juju.nix { };
  notify = self.callPackage ./notify.nix { };
  oil = self.callPackage ./oil.nix { };
  run-command = self.callPackage ./run-command.nix { };
  scooter = self.callPackage ./scooter.nix { };
  smooth-scroll = self.callPackage ./smooth-scroll.nix { };
  splash-hx = self.callPackage ./splash-hx.nix { };
  steel-pty = self.callPackage ./steel-pty.nix { };
  ui-utils = self.callPackage ./ui-utils.nix { };
})
