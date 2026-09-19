{
  lib,
  rustPlatform,
  stdenv,
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
  constructDrv = rustPlatform.buildRustPackage;
  excludeDrvArgNames = [
    "cogName"
    "pluginDependencies"
    "updateVersion"
    "doSteelCheck"
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
      doSteelCheck = args.doSteelCheck or false;

      installNativeLibsTo = targetDir: ''
        for file in target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/*${stdenv.hostPlatform.extensions.sharedLibrary}; do
          install -Dm 755 "$file" -t "${targetDir}/"
        done
      '';
    in
    {
      name = args.name or "helix-plugin-${pname}-${version}";

      strictDeps = args.strictDeps or true;
      __structuredAttrs = args.__structuredAttrs or true;

      outputs =
        args.outputs or [
          "out"
          "native"
        ];

      cargoBuildFlags = (args.cargoBuildFlags or [ ]) ++ [ "--lib" ];

      nativeCheckInputs = (args.nativeCheckInputs or [ ]) ++ lib.optionals doSteelCheck [ steel ];

      postCheck =
        args.postCheck or (lib.optionalString doSteelCheck ''
          echo "Running Steel tests..." 

          ${setupSteelHomeForTests { inherit pluginDependencies steel-test; }}


          # native lib setup
          mkdir -p $PWD/native
          ${installNativeLibsTo "$PWD/native/"}

          ${runSteelTests}
        '');

      installPhase =
        args.installPhase or ''
          mkdir -p $out $native

          runHook preInstall

          ${installScmFiles}

          ${installNativeLibsTo "$native/"}

          runHook postInstall
        '';

      passthru = {
        inherit cogName pluginDependencies updateVersion;
      }
      // args.passthru or { };
    };
}
