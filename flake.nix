{
  description = "Nix packages for Helix editor plugins";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default/future-26.11";
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
            pkgs = nixpkgs.legacyPackages.${system};
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
        nixpkgs.lib.filterAttrs (
          _: v: nixpkgs.lib.isDerivation v
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
