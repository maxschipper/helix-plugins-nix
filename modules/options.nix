{
  omitBaseOptions ? false,
}:
{ lib, pkgs, ... }:
{
  options.programs.helix = {
    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "List of Steel plugins to install for the Helix editor.";
      example = lib.literalExpression "with pkgs.helixPlugins; [ oil notify scooter ];";
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
