{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.helix;
  inherit (lib.options) mkOption;

  pluginLinks = builtins.listToAttrs (
    map (drv: {
      name = "steel/cogs/${drv.pluginName}";
      value = {
        source = drv;
        clobber = true;
      };
    }) cfg.plugins
  );

  nativePlugins = builtins.filter (drv: drv ? native) cfg.plugins;

  nativeLibLinks = lib.optionalAttrs (nativePlugins != [ ]) {
    "steel/native" = {
      source = pkgs.symlinkJoin {
        name = "helix-plugins-merged-native-libs";
        paths = map (drv: drv.native) nativePlugins;
      };
      clobber = true;
    };
  };

in
{
  options.programs.helix = {
    enable = lib.mkEnableOption "Helix editor with steel plugins";

    package = mkOption {
      type = lib.types.package;
      default = pkgs.steelix;
      description = "The helix package to wrap with steel plugins.";
    };

    plugins = mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "List of Steel plugins to install for the Helix editor.";
      example = lib.literalExpression "with pkgs.helixPlugins; [ oil notify scooter ];";
    };

    installTooling = mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install steel related tooling (steel and steel-lsp)";
      example = lib.literalExpression "true;";
    };

  };

  config = lib.mkIf cfg.enable {
    packages = [
      pkgs.steelix
    ]
    ++ lib.optionals cfg.installTooling [
      pkgs.steel
      pkgs.steel-language-server
    ];

    xdg.data.files = pluginLinks // nativeLibLinks;
  };
}
