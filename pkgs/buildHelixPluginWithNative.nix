{ rustPlatform, lib }:

{
  pname,
  version,
  src,
  cargoHash ? lib.fakeHash,
  ...
}@args:
let
  extraArgs = removeAttrs args [
    "pname"
    "version"
    "src"
    "cargoHash"
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
  extraArgs
  // {
    name = "helix-plugin-${pname}-${version}";
    inherit
      pname
      version
      src
      cargoHash
      ;
    passthru.pluginName = pname;

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
)
