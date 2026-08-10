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
        force = true;
      };
    }) allPlugins
  );

  nativeLibLink = lib.optionalAttrs (nativeLibDrv != null) {
    "steel/native" = {
      source = nativeLibDrv;
      force = true;
    };
  };

in
{
  imports = [ (import ../options.nix { omitBaseOptions = true; }) ];

  config = lib.mkIf (cfg.enable && cfg.plugins != [ ]) {
    programs.helix.package = lib.mkDefault pkgs.steelix;
    xdg.dataFile = pluginLinks // nativeLibLink;
  };
}
