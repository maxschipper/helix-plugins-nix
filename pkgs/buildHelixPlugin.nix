{
  lib,
  stdenvNoCC,
  steel,
  steel-test,
}:

let
  common = import ./common.nix { inherit lib; };
  inherit (common)
    installScmFiles
    runSteelTests
    setupSteelHomeForTests
    ;
in
lib.extendMkDerivation {
  constructDrv = stdenvNoCC.mkDerivation;
  excludeDrvArgNames = [
    "cogName"
    "pluginDependencies"
    "updateVersion"
    "doSteelCheck"
    "doCheck" # to not bypass the resolved arg
  ];
  extendDrvArgs =
    finalAttrs: args:
    let
      # necessary args
      pname = args.pname; # typically the repo name
      version = args.version; # gets filled out by nix-update

      # optional args
      pluginDependencies = args.pluginDependencies or [ ]; # other plugins that should also be installed
      cogName = args.cogName or pname; # should be the cogs name (also used as the path in the modules)
      updateVersion = args.updateVersion or "stable"; # used for the update script; should be "stable" for tags, "unstable" for tags with "-alpha" suffix or similar, "branch" to follow the default branch, or "skip" if it should be skipped entirely
      doSteelCheck = args.doSteelCheck or args.doCheck or false;

      # internal mapping
      doCheck = doSteelCheck;
    in
    {
      inherit doCheck;

      name = args.name or "helix-plugin-${pname}-${version}";

      strictDeps = args.strictDeps or true;
      __structuredAttrs = args.__structuredAttrs or true;

      dontBuild = args.dontBuild or true;
      dontConfigure = args.dontConfigure or true;

      nativeCheckInputs = (args.nativeCheckInputs or [ ]) ++ lib.optionals doCheck [ steel ];

      checkPhase =
        args.checkPhase or (lib.optionalString doCheck ''
          ${setupSteelHomeForTests { inherit pluginDependencies steel-test; }}

          runHook preCheck

          ${runSteelTests}

          runHook postCheck
        '');

      installPhase =
        args.installPhase or ''
          mkdir -p $out

          runHook preInstall

          ${installScmFiles}

          runHook postInstall
        '';

      passthru = {
        inherit cogName pluginDependencies updateVersion;
        native = null;
      }
      // args.passthru or { };
    };
}
