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

      # ensure no explicit plugins have the same cogname
      assertNoDuplicateExplicitPlugins =
        normalizedPlugins:
        let
          conflicts = lib.filterAttrs (_: drvs: builtins.length drvs > 1) (
            lib.groupBy (p: p.passthru.cogName) normalizedPlugins
          );
          conflictNames = builtins.concatStringsSep ", " (builtins.attrNames conflicts);
        in
        if conflicts != { } then
          throw "helix-plugins-nix: Conflicting explicit definitions for plugin(s): <${conflictNames}> Remove the duplicate entries from your plugins configuration or make sure their cogNames dont collide."
        else
          normalizedPlugins;

    in

    plugins:
    let
      normalized = assertNoDuplicateExplicitPlugins (normalizePlugins plugins);
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
