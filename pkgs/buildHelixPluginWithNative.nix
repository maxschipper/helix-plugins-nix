{
  rustPlatform,
  lib,
  steel,
  steel-test,
}:

args:
rustPlatform.buildRustPackage (
  finalAttrs:
  let
    resolvedArgs = if builtins.isFunction args then args finalAttrs else args;

    # necessary args
    pname = resolvedArgs.pname; # typically the repo name
    version = resolvedArgs.version; # gets filled out by nix-update
    src = resolvedArgs.src;
    cargoHash = resolvedArgs.cargoHash;

    # optional args
    dependencies = resolvedArgs.dependencies or [ ]; # other plugins that should also be installed
    pluginName = resolvedArgs.pluginName or pname; # should be the cogs name (also used as the path in the modules)
    updateVersion = resolvedArgs.updateVersion or "stable"; # used for the update script; should be "stable" for tags, "unstable" for tags with "-alpha" suffix or similar, "branch" to follow the default branch, or "skip" if it should be skipped entirely
    doSteelCheck = resolvedArgs.doSteelCheck or false;

    # only put args here that arent supposed to be merged into the mkDerivation set
    extraArgs = removeAttrs resolvedArgs [
      "pluginName"
      "dependencies"
      "updateVersion"
      "doSteelCheck"
    ];

    linkScmFiles = ''
      find . -type f -name "*.scm" | while read -r file; do
        # if the file is nested create the dir (e.g. src/)
        mkdir -p "$out/$(dirname "$file")"
        cp "$file" "$out/$file"
      done
    '';
  in
  {
    # this inherit is only for readability as these are overwritten by the merge
    # with extraArgs to preserve the source position of src for nix-update to work
    inherit
      pname
      version
      src
      cargoHash
      ;

    strictDeps = true;
    __structuredAttrs = true;

    name = "helix-plugin-${pname}-${version}";

    passthru = { inherit pluginName dependencies updateVersion; };

    outputs = [
      "out"
      "native"
    ];

    cargoBuildFlags = [ "--lib" ];

    nativeCheckInputs = lib.optionals doSteelCheck [ steel ];

    postCheck = lib.optionalString doSteelCheck ''
      echo "Running Steel tests..." 

      export STEEL_HOME=$(mktemp -d)
      mkdir -p $STEEL_HOME/cogs
      ln -s ${steel-test} $STEEL_HOME/cogs/steel-test

      # native lib setup
      rm -rf target/release
      mkdir -p $PWD/native
      find target -maxdepth 3 -type f \( -name "*.so" -o -name "*.dylib" \) -exec cp {} $PWD/native/ \;

      # link plugin deps
      ${
        (lib.concatMapStrings (dep: ''
          ln -s ${dep} $STEEL_HOME/cogs/${dep.pluginName}
        '') dependencies)
      }

      if [ -f tests/run-all.sh ]; then
        echo "Found tests/run-all.sh"
        sh tests/run-all.sh
      elif [ -d tests ]; then
        shopt -s nullglob; test_files=(tests/*.scm); shopt -u nullglob
        
        # fallback to running tests manually if there is no script
        if [ ''${#test_files[@]} -gt 0 ]; then
          echo "No tests/run-all.sh found"
          echo "But found individual test files"
          for f in "''${test_files[@]}"; do
            echo "Running $f..."
            steel "$f"
          done
        else
          echo "no tests found"
        fi
      else
        echo "no tests found"
      fi
    '';

    installPhase = ''
      mkdir -p $out $native

      runHook preInstall

      ${linkScmFiles}

      rm -rf target/release
      find target -maxdepth 3 -type f \( -name "*.so" -o -name "*.dylib" \) -exec cp {} $native/ \;

      runHook postInstall
    '';
  }
  // extraArgs
)
