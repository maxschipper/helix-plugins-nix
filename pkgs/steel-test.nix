{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:
stdenvNoCC.mkDerivation (
  finalAttrs:
  let
    linkScmFiles = ''
      find . -type f -name "*.scm" | while read -r file; do
        # if the file is nested create the dir (e.g. src/)
        mkdir -p "$out/$(dirname "$file")"
        cp "$file" "$out/$file"
      done
    '';
  in
  {
    pname = "steel-test";
    version = "0.5.0";

    src = fetchFromGitHub {
      owner = "waddie";
      repo = finalAttrs.pname;
      tag = "v${finalAttrs.version}";
      hash = "sha256-I20cwSKOcn0mLvGUy5uQRCuf3wSp6CRxsI5Co9D6VrY=";
    };

    strictDeps = true;
    __structuredAttrs = true;

    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      mkdir -p $out

      runHook preInstall

      ${linkScmFiles}

      runHook postInstall
    '';

    meta = {
      description = "Unit testing for Steel Scheme, modelled on clojure.test";
      homepage = "https://github.com/waddie/steel-test";
      license = lib.licenses.mit;
      # maintainers = with lib.maintainers; [ ];
    };
  }
)
