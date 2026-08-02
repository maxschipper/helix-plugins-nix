{ pkgs, lib }:
{
  # generates the full list of plugins that need to be installed
  flattenPlugins =
    plugins:
    let
      toNode = p: {
        key = p.cogName;
        val = p;
      };
    in
    map (item: item.val) (
      lib.genericClosure {
        startSet = map toNode plugins;
        operator = item: map toNode (item.val.pluginDependencies or [ ]);
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
