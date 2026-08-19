# helix-plugins-nix

[Codeberg Repo](https://codeberg.org/maxschipper/helix-plugins-nix) | [GitHub Mirror](https://github.com/maxschipper/helix-plugins-nix)

To use plugins in Helix you need to compile the [`steel-event-system`](https://github.com/mattwparas/helix/tree/steel-event-system) branch. Luckily this is already packaged in NixOS so you can just use `pkgs.steelix` instead of `pkgs.helix`.


## Modules

First of all add this flake to your inputs set in your `flake.nix`.

```nix
{
  inputs.helix-plugins.url = "github:maxschipper/helix-plugins-nix";
  # or use the codeberg repo directly
  # inputs.helix-plugins.url = "git+ssh://git@codeberg.org/maxschipper/helix-plugins-nix.git";
}
```

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

There also is a home-manager module but i haven't had time to test it. It is a direct port of the hjem module sharing 99% of the code.
This also sets `programs.helix.package = lib.mkDefault pkgs.steelix`.


### Manual

You also have the option to manually build each plugin and copy/symlink it over to `~/.local/share/steel/cogs/` by hand.

Just remember to also build and copy the native library to `~/.local/share/steel/native`.

```sh
nix build "github:maxschipper/helix-plugins-nix#helixPlugins.oil"
# or
# nix build "git+https://codeberg.org/maxschipper/helix-plugins-nix.git#helixPlugins.oil"

cp -rL result ~/.local/share/steel/cogs/oil

# append or ^native for plugins with a native lib to also build that output. ^* builds all outputs
nix build "github:maxschipper/helix-plugins-nix#helixPlugins.scooter^*"

cp -rL result ~/.local/share/steel/cogs/scooter
cp -L result-native/libscooter_hx.so ~/.local/share/steel/native/
```


## Packaged Plugins

Take a look at [pkgs/helixPlugins/](./pkgs/helixPlugins/) to see a list of all the packaged plugins.


## Thanks

A special thanks to [mattwparas](https://github.com/mattwparas) for creating the helix plugin system and to all the people who wrote these plugins.


