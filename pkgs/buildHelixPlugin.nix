{ stdenv }:
{
  pname,
  version,
  src,
  pluginDependencies ? [ ],
  ...
}@args:
let
  extraArgs = removeAttrs args [
    "pname"
    "version"
    "src"
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
stdenv.mkDerivation (
  extraArgs
  // {
    inherit version src pname;
    name = "helix-plugin-${pname}-${version}";
    passthru = (args.passthru or { }) // {
      pluginName = pname;
      inherit pluginDependencies;
    };

    installPhase = ''
      mkdir -p $out
      ${linkScmFiles}
    '';
  }
)
