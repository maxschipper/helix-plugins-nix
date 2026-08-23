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

  steelHome = pkgs.symlinkJoin {
    name = "helix-steel-home";
    paths = [
      (pkgs.linkFarm "helix-plugin-cogs" (
        map (drv: {
          name = "cogs/${drv.cogName}";
          path = drv;
        }) allPlugins
      ))
    ]
    ++ lib.optional (nativeLibDrv != null) (
      pkgs.linkFarm "helix-plugin-native" [
        {
          name = "native";
          path = nativeLibDrv;
        }
      ]
    );
  };
in
{
  imports = [ (import ../options.nix { }) ];

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.symlinkJoin {
        name = "${cfg.package.name}-steel-wrapped";
        paths = [ cfg.package ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = lib.optionalString (cfg.plugins != [ ]) ''
          rm -rf $out/bin
          mkdir -p $out/bin

          for f in ${cfg.package}/bin/*; do

            bin_name=$(basename "$f")
            makeWrapper "$f" "$out/bin/$bin_name" \
              --run 'export STEEL_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}/helix-steel"' \
              --run 'if [ ! -f "$STEEL_HOME/.nix-store-path" ] || [ "$(cat "$STEEL_HOME/.nix-store-path")" != "${steelHome}" ]; then rm -rf "$STEEL_HOME"; mkdir -p "$STEEL_HOME"; cp -RL --no-preserve=mode "${steelHome}/." "$STEEL_HOME/"; chmod -R u+w "$STEEL_HOME"; echo "${steelHome}" > "$STEEL_HOME/.nix-store-path"; fi'

          done
        '';
      })
    ]
    ++ lib.optional (cfg.package != null) cfg.package;
  };
}
