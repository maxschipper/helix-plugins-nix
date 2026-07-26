{ stdenv }:

# {
#   pname,
#   version,
#   src,
#   pluginName ? null, # used in the modules for linking -> e.g. ~/.local/share/steel/cogs/${cogName}/...
#   cogDependecies ? [ ], # other plugins that also need to be installed
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
    pluginName = resolvedArgs.pluginName or pname;
    dependencies = resolvedArgs.dependencies or [ ];

    # only put args here that arent supposed to be in the mkDerivation set
    # otherwise it breaks nix-update's ability to find the source location
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
    inherit pname version src;

    name = "helix-plugin-${pname}-${version}";

    passthru = { inherit pluginName dependencies; };

    installPhase = ''
      mkdir -p $out
      ${linkScmFiles}
    '';
  }
  # this also inherits pname version src
  // extraArgs
)
