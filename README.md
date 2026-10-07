# helix-plugins-nix

[Codeberg Repo](https://codeberg.org/maxschipper/helix-plugins-nix) | [GitHub Mirror](https://github.com/maxschipper/helix-plugins-nix)

This flake provides Nix packages and modules for installing Steel Helix plugins declaratively.
It packages Steel plugins and handles placing both `.scm` files and the optional native Rust libraries in Steel's runtime directories.

To use plugins in Helix you need to compile the [`steel-event-system`](https://github.com/mattwparas/helix/blob/steel-event-system/STEEL.md) branch.
Luckily this is already packaged in NixOS so you can just use `pkgs.steelix` instead of `pkgs.helix`.

The modules use `pkgs.steelix` as the default Helix package, so you don't need to configure it explicitly.

> [!NOTE]
> The grammars bundled with `pkgs.steelix` are currently outdated. After installing Steelix, run the following commands to fetch and build the current grammars:
> ```sh
> hx --grammar fetch
> hx --grammar build
> ```
> This installs the grammars into `~/.config/helix/runtime/grammars/`, which overrides the globally installed ones.
> You only need to do this once (or again when you want to update the grammars).

---

## Flake Input

Add this flake to your inputs set in your `flake.nix`.

```nix
{
  inputs = {
    helix-plugins.url = "github:maxschipper/helix-plugins-nix"; # or "git+ssh://git@codeberg.org/maxschipper/helix-plugins-nix.git"
    # helix-plugins.inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

---


## [Hjem](https://github.com/feel-co/hjem) Module

Installs the plugins into `~/.local/share/steel/cogs/` and native Rust libraries into `~/.local/share/steel/native/`.

```nix
{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.helix-plugins.overlays.default ];
  hjem.extraModules = [ inputs.helix-plugins.hjemModules.default ]; # or inputs.helix-plugins.hjemModules.rum

  hjem.users.<username>.programs.helix = {
    enable = true;
    plugins = with pkgs.helixPlugins; [
      notify-hx
      oil-hx
      smooth-scroll-hx
    ];
  };
}
```

> [!NOTE]
> If you use [`hjem-rum`](https://github.com/snugnug/hjem-rum) you need to use the compatible `helix-plugins.hjemModules.rum` module instead of the `default` one. This omits options like `programs.helix.enable` because they are already provided by `hjem-rum` and would otherwise clash. It will still function like the default module.

---

## Home Manager Module

The Home-Manager module provides the same features and syntax as the Hjem module.

### Home Manager NixOS Module

In your NixOS configuration:

```nix
{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.helix-plugins.overlays.default ];

  home-manager.users.<username> = {
    imports = [ inputs.helix-plugins.homeManagerModules.default ];

    programs.helix = {
      enable = true;
      plugins = with pkgs.helixPlugins; [
        notify-hx
        oil-hx
        smooth-scroll-hx
      ];
    };
  };
}
```

### Standalone Home Manager

In your home-manager configuration:

```nix
{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.helix-plugins.overlays.default ];
  imports = [ inputs.helix-plugins.homeManagerModules.default ];

  programs.helix = {
    enable = true;
    plugins = with pkgs.helixPlugins; [
      notify-hx
      oil-hx
      smooth-scroll-hx
    ];
  };
}
```

---

## Configuring Plugins in Helix

After installing plugins with one of the modules, you will still need to set them up in your `~/.config/helix/init.scm`.

I recommend taking a look at each plugin's README to see what you need to configure. Most of the time, you just need to `require` the plugin, but you can often also change some options or add keybinds as well.

For example, if you install `helixPlugins.yank-flash-hx`, this is enough:

```scheme
;; init.scm
(require "yank-flash/yank-flash.scm")
```

But other plugins might need more setup. For example, `helixPlugins.breadcrumbs-hx`:

```scheme
;; init.scm
(require "breadcrumbs/breadcrumbs.scm")

;; add callable breadcrumbs cmd
(provide breadcrumbs)

;; add to your keymap:
(keymap (normal (space (B ":breadcrumbs"))))
```

---

## Packaged Plugins

Take a look at [pkgs/helixPlugins/](./pkgs/helixPlugins/) to see a list of all the packaged plugins.

## Adding plugins that are not packaged here

The modules not only support programs.helix.plugins as a list of plugins but also as an attribute set.

This way custom plugins that aren't packaged here can be installed.

To install a new plugin that doesn't have a native Rust library do this:

```nix
plugins = {
  "ogre.hx" = pkgs.fetchFromGitHub {
    owner = "waddie";
    repo = "ogre.hx";
    tag = "v0.1.0";
    hash = "sha256-AxMuF/BUnvw8vsxglnLGzCLP627JVgKFcrbFq1+2G8Q=";
  };
};
```

This installs all `.scm` files of the repo into `~/.local/share/steel/cogs/ogre.hx`.
So make sure to match the attribute key to what the plugin specifies as its package-name in `cog.scm`.
If it contains a literal dot "." you need to wrap the key in quotes like in the example, otherwise Nix will interpret `hx` as an attribute of `ogre`.

You can also use this repo's custom builder functions, which give you more control over the build.
This is needed if the plugin has a native Rust library, if you want to enable tests, or if you need to tweak the build.

If you use the `buildHelixPlugin` functions the attribute key doesnt matter. Instead `passthru.cogName` is used to determine where to install the plugin to.

I recommend looking at their sources and how they are used for all the packaged plugins:
- [buildHelixPlugin](./pkgs/buildHelixPlugin.nix)
- [buildHelixPluginWithNative](./pkgs/buildHelixPluginWithNative.nix)

```nix
plugins = {
  "scooter" = pkgs.helixPlugins.buildHelixPluginWithNative {
    pname = "scooter.hx";
    version = "0.2.0";
    src = pkgs.fetchFromGitHub {
      owner = "thomasschafer";
      repo = "scooter.hx";
      tag = "v0.2.0";
      hash = "sha256-pxvD4yJ1qtS4lUpJIIJZdYnDEYY415aZ03ufBoIt6hQ=";
    };
    cargoHash = "sha256-QQ9ISkhRUsp/FNiMHSzZTfWmpnU7AD84bdo3GkIbjOo=";
    doCheck = false;
    passthru.cogName = "scooter";
  };
};
```
  
Of course you can also install the packaged plugins this way:

```nix
plugins = {
  inherit (pkgs.helixPlugins)
    show-keys-hx
    moka-hx
    ;
};
```

---

## Manually building plugins

You also have the option to manually build each plugin and copy/symlink it over to `~/.local/share/steel/cogs/` by hand.

This is totally unnecessary for normal plugins without native libraries but if you want to build the Rust native library for a plugin this is a good way to do so.

Just remember to also build and copy the native library to `~/.local/share/steel/native`.

```sh
nix build "github:maxschipper/helix-plugins-nix#oil-hx"
# or
# nix build "git+https://codeberg.org/maxschipper/helix-plugins-nix.git#oil-hx"

cp -rL result ~/.local/share/steel/cogs/oil

# append ^* for plugins with a native lib to also build that output. ^* builds all outputs of a derivation
# to only build the native output you can use ^native
nix build "github:maxschipper/helix-plugins-nix#helixPlugins.scooter-hx^*"

cp -rL result ~/.local/share/steel/cogs/scooter
cp -L result-native/libscooter_hx.so ~/.local/share/steel/native/
```

---

## Experimental NixOS Module

This was an attempt to hack around the fact that Helix needs write access to `~/.local/share/steel/cogs/helix` by creating a wrapper that copies the plugins over on the first run.

This was just a proof of concept and experimental.
I don't recommend actually using this.

```nix
{ pkgs, inputs, ... }:
{
  imports = [ inputs.helix-plugins.nixosModules.default ];
  nixpkgs.overlays = [ inputs.helix-plugins.overlays.default ];

  programs.helix = {
    enable = true;
    plugins = with pkgs.helixPlugins; [
      oil-hx
      forest-hx
      moka-hx
    ];
  };
}
```

---

## Thanks

A special thanks to [mattwparas](https://github.com/mattwparas) for creating the steel helix plugin system and to all the people who wrote these plugins.

And if you need help setting anything up on the Nix side, you can send me a DM on Matrix [@maxschipper:matrix.org](https://matrix.to/#/@maxschipper:matrix.org) or open an issue right here.
