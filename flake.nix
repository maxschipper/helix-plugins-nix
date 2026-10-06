{
  description = "Nix packages for Helix editor plugins";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
    }:
    let
      forAllSystems = (
        f:
        nixpkgs.lib.genAttrs (import systems) (
          system:
          f {
            inherit system;
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          }
        )
      );
    in
    {
      legacyPackages = forAllSystems (
        { pkgs, ... }: {
          helixPlugins = pkgs.callPackage ./pkgs { };
        }
      );

      packages = forAllSystems (
        { system, ... }:
        let
          aliasKeys = builtins.attrNames (
            import ./pkgs/aliases.nix {
              lib = nixpkgs.lib;
              helixPlugins = null;
            }
          );
        in
        nixpkgs.lib.filterAttrs (
          n: v: nixpkgs.lib.isDerivation v && !(builtins.elem n aliasKeys)
        ) self.legacyPackages.${system}.helixPlugins
      );

      checks = self.packages;

      overlays.default = final: prev: {
        helixPlugins = final.callPackage ./pkgs { };
      };

      nixosModules.default = ./modules/nixos;
      hjemModules.default = ./modules/hjem;
      hjemModules.rum = ./modules/hjem/rum.nix;
      homeManagerModules.default = ./modules/home-manager;

      formatter = forAllSystems ({ pkgs, ... }: pkgs.nixfmt-tree);
    };
}
