{ stdenvNoCC }:

args:
stdenvNoCC.mkDerivation (
  finalAttrs:
  let
    resolvedArgs = if builtins.isFunction args then args finalAttrs else args;

    # necessary args
    pname = resolvedArgs.pname; # typically the repo name
    version = resolvedArgs.version; # gets filled out by nix-update
    src = resolvedArgs.src;

    # optional args
    dependencies = resolvedArgs.dependencies or [ ]; # other plugins that should also be installed
    pluginName = resolvedArgs.pluginName or pname; # should be the cogs name (also used as the path in the modules)
    updateVersion = resolvedArgs.updateVersion or "stable"; # used for the update script; should be "stable" for tags, "unstable" for tags with "-alpha" suffix or similar, "branch" to follow the default branch, or "skip" if it should be skipped entirely

    # only put args here that arent supposed to be merged into the mkDerivation set
    extraArgs = removeAttrs resolvedArgs [
      "pluginName"
      "dependencies"
      "updateVersion"
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

    strictDeps = true;
    __structuredAttrs = true;

    name = "helix-plugin-${pname}-${version}";

    dontBuild = true;
    dontConfigure = true;

    passthru = {
      inherit pluginName dependencies updateVersion;
      native = null;
    };

    installPhase = ''
      mkdir -p $out

      runHook preInstall

      ${linkScmFiles}

      runHook postInstall
    '';
  }
  # this also inherits pname version src
  // extraArgs
)
