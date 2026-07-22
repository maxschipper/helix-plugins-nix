{ stdenv }:

# {
#   pname,
#   version,
#   src,
#   pluginDependencies ? [ ],
#   ...
# }@args:

args:

stdenv.mkDerivation (
  finalAttrs:
  let
    resolvedArgs = if builtins.isFunction args then args finalAttrs else args;

    pname = resolvedArgs.pname;
    version = resolvedArgs.version;
    src = resolvedArgs.src;
    pluginDependencies = resolvedArgs.pluginDependencies or [ ];

    # only put args here that arent supposed to be in the mkDerivation set
    # otherwise it breaks nix-update's ability to find the source location
    extraArgs = removeAttrs resolvedArgs [
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
  {
    # this inherit is only for readability as these are overwritten by the merge
    # with extraArgs to preserve the source position for nix-update to work
    inherit pname version src;

    name = "helix-plugin-${pname}-${version}";

    passthru = {
      pluginName = pname;
      inherit pluginDependencies;
    };

    installPhase = ''
      mkdir -p $out
      ${linkScmFiles}
    '';
  }
  # this also inherits pname version src
  // extraArgs
)
