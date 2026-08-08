{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    { nixpkgs, systems, ... }:
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

      overlays.default = final: prev: {
        helixPlugins = final.callPackage ./pkgs { };
      };

      nixosModules.default = import ./modules/nixos.nix;
      hjemModules.default = import ./modules/hjem.nix;
      homeManagerModules.default = import ./modules/home-manager.nix;

      formatter = forAllSystems ({ pkgs, ... }: pkgs.nixfmt-tree);
    };
}
