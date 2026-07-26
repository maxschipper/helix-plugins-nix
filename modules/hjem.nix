{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.helix;
  inherit (lib.options) mkOption;

  # generates the full list of plugins that need to be installed
  flattenPlugins =
    plugins:
    let
      toNode = p: {
        key = p.pluginName;
        val = p;
      };
    in
    map (item: item.val) (
      lib.genericClosure {
        startSet = map toNode plugins;
        operator = item: map toNode (item.val.dependencies or [ ]);
      }
    );

  allPlugins = flattenPlugins cfg.plugins;

  nativePlugins = builtins.filter (drv: (drv.native or null) != null) allPlugins;

  pluginLinks = builtins.listToAttrs (
    map (drv: {
      name = "steel/cogs/${drv.pluginName}";
      value = {
        source = drv;
        clobber = true;
      };
    }) allPlugins
  );

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
  };

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.steelix ];
    xdg.data.files = pluginLinks // nativeLibLinks;
  };
}
