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
  imports = [ (import ../options.nix { }) ];
  config = lib.mkIf cfg.enable {
    packages = [ pkgs.steelix ];
    xdg.data.files = pluginLinks // nativeLibLink;
  };
}
