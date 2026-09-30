{ pkgs, lib }:
let
  common = import ../pkgs/common.nix { inherit lib; };
  inherit (common) installScmFiles;
in
{
  # generates the full list of plugins that need to be installed
  flattenPlugins =
    let
      # if cfg.plugins is an attrset it normalizes it to a list and uses the unpackaged custom sources to build custom plugins
      normalizePlugins =
        plugins:
        if builtins.isList plugins then
          plugins
        else
          lib.mapAttrsToList (
            name: value:
            if (value ? passthru && value.passthru ? cogName) then
              value
            else
              pkgs.stdenvNoCC.mkDerivation {
                name = "helix-plugin-${name}-custom";
                src = value;
                dontBuild = true;
                dontConfigure = true;
                installPhase = ''
                  mkdir -p $out
                  ${installScmFiles}
                '';
                passthru.cogName = name;
              }
          ) plugins;
    in
    plugins:
    let
      normalized = normalizePlugins plugins;
      toNode = p: {
        key = p.passthru.cogName;
        val = p;
      };
    in
    map (item: item.val) (
      lib.genericClosure {
        startSet = map toNode normalized;
        operator = item: map toNode (item.val.passthru.pluginDependencies or [ ]);
      }
    );

  getNativePlugins = allPlugins: builtins.filter (drv: (drv.native or null) != null) allPlugins;

  mergeNativeLibs =
    nativePlugins:
    if nativePlugins == [ ] then
      null
    else
      pkgs.symlinkJoin {
        name = "helix-plugins-merged-native-libs";
        paths = map (drv: drv.native) nativePlugins;
      };
}
