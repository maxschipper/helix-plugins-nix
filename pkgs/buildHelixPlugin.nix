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
    "doSteelCheck"
    "doCheck" # plugins should use doSteelCheck
  ];
  extendDrvArgs =
    finalAttrs: args:
    let
      doSteelCheck = args.doSteelCheck or false; # run steel scheme tests
      pluginDependencies = (args.passthru or { }).pluginDependencies or [ ];
    in
    {
      name = args.name or "helix-plugin-${args.pname}-${args.version}";

      strictDeps = args.strictDeps or true;
      __structuredAttrs = args.__structuredAttrs or true;

      dontBuild = args.dontBuild or true;
      dontConfigure = args.dontConfigure or true;

      doCheck = doSteelCheck;

      nativeCheckInputs = (args.nativeCheckInputs or [ ]) ++ lib.optionals doSteelCheck [ steel ];

      checkPhase =
        args.checkPhase or (lib.optionalString doSteelCheck ''
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

      # override these via passthru.cogName for example
      passthru = {
        cogName = args.pname; # the cog's directory name used by the modules
        updateVersion = "stable"; # "stable" | "unstable" | "branch" | "skip", used by the update script
        pluginDependencies = [ ]; # other plugins that need to be installed alongside, used by the modules
      }
      // (args.passthru or { });
    };
}
