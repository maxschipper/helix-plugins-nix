{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.helix;

  utils = import ../utils.nix { inherit lib pkgs; };

  allPlugins = utils.flattenPlugins cfg.plugins;
  nativePlugins = utils.getNativePlugins allPlugins;
  nativeLibDrv = utils.mergeNativeLibs nativePlugins;

  pluginLinks = builtins.listToAttrs (
    map (drv: {
      name = "steel/cogs/${drv.cogName}";
      value = {
        source = drv;
        clobber = true;
      };
    }) allPlugins
  );

  nativeLibLink = lib.optionalAttrs (nativeLibDrv != null) {
    "steel/native" = {
      source = nativeLibDrv;
      clobber = true;
    };
  };
in
{
  config = lib.mkIf cfg.enable {
    packages = lib.optional (cfg.package != null) cfg.package;
    xdg.data.files = pluginLinks // nativeLibLink;
  };
}
