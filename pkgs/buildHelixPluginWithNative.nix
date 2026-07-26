{ rustPlatform, lib }:

# {
#   pname,
#   version,
#   src,
#   cargoHash ? lib.fakeHash,
#   pluginName ? null, # used in the modules for linking -> e.g. ~/.local/share/steel/cogs/${cogName}/...
#   cogDependecies ? [ ], # other plugins that also need to be installed
#   ...
# }@args:

args:

rustPlatform.buildRustPackage (
  finalAttrs:
  let
    resolvedArgs = if builtins.isFunction args then args finalAttrs else args;

    # src
    pname = resolvedArgs.pname;
    version = resolvedArgs.version;
    src = resolvedArgs.src;
    cargoHash = resolvedArgs.cargoHash or lib.fakeHash;
    pluginName = resolvedArgs.pluginName or pname;
    dependencies = resolvedArgs.dependencies or [ ];

    # everything that is supposed to be in the main buildRustPackage set needs
    # to remain in extraArgs so nix-update can find the source location
    extraArgs = removeAttrs resolvedArgs [
      "pluginName"
      "dependencies"
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

    passthru = { inherit pluginName dependencies; };

    outputs = [
      "out"
      "native"
    ];

    cargoBuildFlags = [ "--lib" ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out $native

      ${linkScmFiles}

      rm -rf target/release
      find target -maxdepth 3 -type f \( -name "*.so" -o -name "*.dylib" \) -exec cp {} $native/ \;

      runHook postInstall
    '';
  }
  // extraArgs
)
