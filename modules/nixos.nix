{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.helix;
  inherit (lib.options) mkOption;

  utils = import ./utils.nix { inherit lib pkgs; };

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
    )
    ++ cfg.extraPaths;
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

    extraPaths = mkOption {
      type = lib.types.listOf lib.types.path;
      default = [ ];
      description = ''
        Additional paths to merge directly into the root of STEEL_HOME.
        This is useful for providing the core helix cog or lsp builtins.

        The provided paths should be directories containing the files in
        their correct relative locations (e.g. `cogs/helix/cog.scm`, `lsp/...`).
      '';
      example = lib.literalExpression "[ ./helix_steel_runtime ]";
    };

    steelHome = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
      default = steelHome;
      defaultText = lib.literalExpression "programs.helix.plugins";
      description = ''
        The constructed STEEL_HOME derivation containing all configured
        plugins. This is set automatically and should not be overridden.
      '';
    };

  };

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
              --run 'if [ ! -f "$STEEL_HOME/.nix-store-path" ] || [ "$(cat "$STEEL_HOME/.nix-store-path")" != "${cfg.steelHome}" ]; then rm -rf "$STEEL_HOME"; mkdir -p "$STEEL_HOME"; cp -RL --no-preserve=mode "${cfg.steelHome}/." "$STEEL_HOME/"; chmod -R u+w "$STEEL_HOME"; echo "${cfg.steelHome}" > "$STEEL_HOME/.nix-store-path"; fi'

          done
        '';
      })
    ];
  };
}
