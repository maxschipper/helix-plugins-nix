{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.helix;
  inherit (lib.options) mkOption;

  nativePlugins = builtins.filter (drv: drv ? native) cfg.plugins;

  steelHome = pkgs.symlinkJoin {
    name = "helix-steel-home";
    paths = [
      (pkgs.linkFarm "helix-plugin-cogs" (
        map (drv: {
          name = "cogs/${drv.pluginName}";
          path = drv;
        }) cfg.plugins
      ))
    ]
    ++ lib.optional (nativePlugins != [ ]) (
      pkgs.linkFarm "helix-plugin-native" [
        {
          name = "native";
          path = pkgs.symlinkJoin {
            name = "helix-plugin-merged-native-libs";
            paths = map (drv: drv.native) nativePlugins;
          };
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

    installTooling = mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install steel related tooling (steel and steel-lsp)";
      example = lib.literalExpression "true;";
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

    environment = {
      systemPackages = [
        (pkgs.symlinkJoin {
          name = "${cfg.package.name}-steel-wrapped";
          paths = [ cfg.package ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = lib.optionalString (cfg.plugins != [ ]) ''
            for f in $out/bin/*; do
              wrapProgram "$f" \
                --run 'export STEEL_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}/helix-steel"' \
                --run 'if [ ! -f "$STEEL_HOME/.nix-store-path" ] || [ "$(cat "$STEEL_HOME/.nix-store-path")" != "${cfg.steelHome}" ]; then rm -rf "$STEEL_HOME"; mkdir -p "$STEEL_HOME"; cp -RL --no-preserve=mode "${cfg.steelHome}/." "$STEEL_HOME/"; chmod -R u+w "$STEEL_HOME"; echo "${cfg.steelHome}" > "$STEEL_HOME/.nix-store-path"; fi'
            done
          ''; # [todo] messes up HELIX_RUNTIME wrapper by the original helix/steelix package
        })
      ]
      ++ lib.optionals cfg.installTooling [
        pkgs.steel
        pkgs.steel-language-server
      ];
    };
  };
}
