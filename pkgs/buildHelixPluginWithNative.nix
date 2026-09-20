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
    "doSteelCheck"
    # doCheck needs to be passed through to buildRustPackage and enables cargo tests
  ];
  extendDrvArgs =
    finalAttrs: args:
    let
      doSteelCheck = args.doSteelCheck or false; # run steel scheme tests
      pluginDependencies = (args.passthru or { }).pluginDependencies or [ ];

      installNativeLibsTo = targetDir: ''
        for file in target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/*${stdenv.hostPlatform.extensions.sharedLibrary}; do
          install -Dm 755 "$file" -t "${targetDir}/"
        done
      '';
    in
    {
      name = args.name or "helix-plugin-${args.pname}-${args.version}";

      strictDeps = args.strictDeps or true;
      __structuredAttrs = args.__structuredAttrs or true;

      outputs =
        args.outputs or [
          "out"
          "native"
        ];

      cargoBuildFlags = (args.cargoBuildFlags or [ ]) ++ [ "--lib" ];

      doCheck = args.doCheck or true;

      installPhase =
        args.installPhase or ''
          mkdir -p $out $native

          runHook preInstall

          ${installScmFiles}

          ${installNativeLibsTo "$native/"}

          runHook postInstall
        '';

      # steel tests run in installCheckPhase so they dont override the cargo test phase by buildRustPackage
      doInstallCheck = doSteelCheck;
      installCheckInputs = (args.installCheckInputs or [ ]) ++ lib.optionals doSteelCheck [ steel ];
      installCheckPhase = lib.optionalString doSteelCheck ''
        runHook preInstallCheck

        echo "Running Steel tests..." 

        ${setupSteelHomeForTests { inherit pluginDependencies steel-test; }}

        # native lib setup
        mkdir -p $PWD/native
        ${installNativeLibsTo "$PWD/native/"}

        ${runSteelTests}

        runHook postInstallCheck
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
