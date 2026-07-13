{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.helix;
  inherit (lib.options) mkOption;

  flattenPlugins =
    plugins:
    map (item: item.val) (
      lib.genericClosure {
        startSet = map (p: {
          key = p.pluginName;
          val = p;
        }) plugins;
        operator =
          item:
          map (p: {
            key = p.pluginName;
            val = p;
          }) (item.val.pluginDependencies or [ ]);
      }
    );

  allPlugins = flattenPlugins cfg.plugins;

  pluginLinks = builtins.listToAttrs (
    map (drv: {
      name = "steel/cogs/${drv.pluginName}";
      value = {
        source = drv;
        clobber = true;
      };
    }) allPlugins
  );

  nativePlugins = builtins.filter (drv: drv ? native) allPlugins;

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
