{
  omitBaseOptions ? false,
}:
{ lib, pkgs, ... }:
let
  inherit (lib.options) mkOption mkEnableOption;
in
{
  options.programs.helix = {
    plugins = mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "List of Steel plugins to install for the Helix editor.";
      example = lib.literalExpression "with pkgs.helixPlugins; [ oil notify scooter ];";
    };
  }
  // lib.optionalAttrs (!omitBaseOptions) {
    enable = mkEnableOption "Helix editor with steel plugins";

    package = mkOption {
      type = lib.types.package;
      default = pkgs.steelix;
      description = "The helix package to wrap with steel plugins.";
    };
  };
}
