# helix-plugins-nix

## Modules

### NixOS Module

This was an attempt to hack around the fact that Helix needs write access to `~/.local/share/steel/` by creating a wrapper that copies the plugins over on the first run.

I think by wrapping helix again there is some issue with the prebuilt grammars, so I would not recommend using this module.

```nix
{ pkgs, inputs, ... }:
{
  imports = [ inputs.helix-plugins.nixosModules.default ];
  nixpkgs.overlays = [ inputs.helix-plugins.overlays.default ];

  programs.helix = {
    enable = true;
    plugins = with pkgs.helixPlugins; [
      oil
      forest
      moka
    ];
  };
}
```


### [Hjem](https://github.com/feel-co/hjem) Module

Nice way to symlink everything into `~/.local/share/steel/cogs/` and `~/.local/share/steel/native/`.

I personally use this every day like this:

```nix
{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.helix-plugins.overlays.default ];
  hjem.extraModules = [ inputs.helix-plugins.hjemModules.default ];

  hjem.users.<username>.programs.helix = {
    enable = true;
    plugins = with pkgs.helixPlugins; [
      notify
      oil
      smooth-scroll
      forest
      glyph
      show-keys
      moka
    ];
  };
}
```


### Home Manager Module

Not yet implemented.
I don't use Home Manager but I guess the module would look very similar to the Hjem Module. Both could probably share a lot of code.


### Manual

You also have the option to manually build each plugin and copy/symlink it over to `~/.local/share/steel/cogs/` by hand.

Just remember to also build and copy the native library to `~/.local/share/steel/native`.

```sh
nix build "git+https://codeberg.org/maxschipper/helix-plugins-nix.git#helixPlugins.oil"

cp -rL result ~/.local/share/steel/cogs/oil

# append or ^native for plugins with a native lib to also build that output. ^* builds all outputs
nix build "git+https://codeberg.org/maxschipper/helix-plugins-nix.git#helixPlugins.scooter^*"

cp -rL result ~/.local/share/steel/cogs/scooter
cp -L result-native/libscooter_hx.so ~/.local/share/steel/native/
```


## Packaged Plugins

- [chuwy/microscope.hx](https://github.com/chuwy/microscope.hx)
  - `helixPlugins.microscope`
  - not tested

- [chuwy/notify.hx](https://github.com/chuwy/notify.hx)
  - `helixPlugins.notify`

- [daynardn/HeTeX.hx](https://github.com/daynardn/HeTeX.hx)
  - `helixPlugins.hetex`
  - didn't get this to work
  - you need to provide a derivation for libtexprintf for this plugin ([example](https://codeberg.org/maxschipper/nix/src/branch/main/pkgs/libtexprintf/package.nix))

- [gllms/streal.hx](https://github.com/gllms/streal.hx)
  - `helixPlugins.streal`

- [godalming123/switcheroo.hx](https://github.com/godalming123/switcheroo.hx)
  - `helixPlugins.switcheroo`
  - not further tested

- [gwid/modeline.hx](https://codeberg.org/gwid/modeline.hx)
  - `helixPlugins.modeline`
  - not further tested

- [HeitorAugustoLN/showkeys.hx](https://github.com/HeitorAugustoLN/showkeys.hx)
  - `helixPlugins.show-keys`

- [mattwparas/file-tree.hx](https://github.com/mattwparas/file-tree.hx)
  - `helixPlugins.file-tree-hx`
  - not tested

- [mattwparas/helix-file-watcher](https://github.com/mattwparas/helix-file-watcher)
  - `helixPlugins.helix-file-watcher`
  - didn't get this to work

- [mattwparas/splash.hx](https://github.com/mattwparas/splash.hx)
  - `helixPlugins.splash-hx`

- [mattwparas/steel-pty](https://github.com/mattwparas/steel-pty)
  - `helixPlugins.steel-pty`

- [mattwparas/vim.hx](https://github.com/mattwparas/vim.hx)
  - `helixPlugins.vim`

- [notnmeyer/zen-mode.hx](https://github.com/notnmeyer/zen-mode.hx)
  - `helixPlugins.zen-mode`

- [piotrkwarcinski/hx-tmux-navigator](https://github.com/piotrkwarcinski/hx-tmux-navigator)
  - `helixPlugins.hx-tmux-navigator`
  - not further tested

- [Ra77a3l3-jar/anchor.hx](https://github.com/Ra77a3l3-jar/anchor.hx)
  - `helixPlugins.anchor`

- [Ra77a3l3-jar/forest.hx](https://github.com/Ra77a3l3-jar/forest.hx)
  - `helixPlugins.forest`

- [Ra77a3l3-jar/glyph.hx](https://github.com/Ra77a3l3-jar/glyph.hx)
  - `helixPlugins.glyph`

- [Ra77a3l3-jar/moka.hx](https://github.com/Ra77a3l3-jar/moka.hx)
  - `helixPlugins.moka`

- [Ra77a3l3-jar/oil.hx](https://github.com/Ra77a3l3-jar/oil.hx)
  - `helixPlugins.oil`

- [Ra77a3l3-jar/trail.hx](https://github.com/Ra77a3l3-jar/trail.hx)
  - `helixPlugins.trail`

- [Ra77a3l3-jar/who.hx](https://github.com/Ra77a3l3-jar/who.hx)
  - `helixPlugins.who`

- [shybovycha/flash.hx](https://github.com/shybovycha/flash.hx)
  - `helixPlugins.flash`

- [sipmann/hxwiki](https://github.com/sipmann/hxwiki)
  - `helixPlugins.hxwiki`
  - not working on linux ootb (env-var USERPROFILE isn't defined)
  - not further tested

- [thomasschafer/scooter.hx](https://github.com/thomasschafer/scooter.hx)
  - `helixPlugins.scooter`

- [thomasschafer/smooth-scroll.hx](https://github.com/thomasschafer/smooth-scroll.hx)
  - `helixPlugins.smooth-scroll`

- [waddie/juju](https://github.com/waddie/juju)
  - `helixPlugins.juju`

- [waddie/run-command.scm](https://github.com/waddie/run-command.scm)
  - `helixPlugins.run-command`

- [waddie/ui-utils.hx](https://github.com/waddie/ui-utils.hx)
  - `helixPlugins.ui-utils`

- [Xerxes-2/fake-warp.hx](https://github.com/Xerxes-2/fake-warp.hx)
  - `helixPlugins.fake-warp`

- [Xerxes-2/wakatime.hx](https://github.com/Xerxes-2/wakatime.hx)
  - `helixPlugins.wakatime`
  - not further tested


## Thanks

A special thanks to mattwparas for creating the helix plugin system and to all the people who wrote these plugins.
