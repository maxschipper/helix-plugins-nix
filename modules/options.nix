{
  omitBaseOptions ? false,
}:
{ lib, pkgs, ... }:
{
  options.programs.helix = {
    plugins = lib.mkOption {
      type = with lib.types; either (listOf package) (attrsOf (either package path));
      default = [ ];
      description = "List or attribute set of Steel plugins to install for the Helix editor. Can be pre-packaged plugins or plugin sources.";
      example = lib.literalExpression ''
        {
          inherit (pkgs.helixPlugins) oil notify scooter;
          open-with-cmd = pkgs.fetchFromGitHub {
            owner = "Ape";
            repo = "open-with-cmd.yazi";
            rev = "56705e2d378f8ab6c898981d90bddeb65ed4b748";
            hash = "sha256-VClpoa3T4uVrJzdGlWHpCnaWLY1Kdk5xIIDksibScpM=";
          };
        }
      '';
    };
  }
  // lib.optionalAttrs (!omitBaseOptions) {
    enable = lib.mkEnableOption "Helix editor with steel plugins";

    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = pkgs.steelix;
      description = "The helix package to wrap with steel plugins.";
    };
  };
}
