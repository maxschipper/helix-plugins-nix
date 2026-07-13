{ rustPlatform, lib }:

{
  pname,
  version,
  src,
  cargoHash ? lib.fakeHash,
  pluginDependencies ? [ ],
  ...
}@args:
let
  # only put args here that arent supposed to be in the mkDerivation set
  # otherwise it breaks nix-update's ability to find the source location
  extraArgs = removeAttrs args [
    "pluginDependencies"
  ];

  linkScmFiles = ''
    find . -type f -name "*.scm" | while read -r file; do
      # if the file is nested create the dir (e.g. src/)
      mkdir -p "$out/$(dirname "$file")"
      cp "$file" "$out/$file"
    done
  '';
in
rustPlatform.buildRustPackage (
  {
    # this inherit is only for readability as these are overwritten by the merge
    # with extraArgs to preserve the source position for nix-update to work
    inherit
      pname
      version
      src
      cargoHash
      ;

    name = "helix-plugin-${pname}-${version}";

    passthru = {
      pluginName = pname;
      inherit pluginDependencies;
    };

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
