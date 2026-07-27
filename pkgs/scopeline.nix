{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  glyph,
}:
buildHelixPlugin (finalAttrs: {
  pname = "scopeline";
  version = "0.1.0-unstable-2026-07-27";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = finalAttrs.pname;
    rev = "19352d57b0b2c2315773b854b96f543b7251e853";
    # tag = "v${finalAttrs.version}";
    hash = "sha256-tbOqWSF+dvqW84zaZ4oK5RPe6Euan4MafO+VHUktO4I=";
  };

  dependencies = [
    glyph
  ];

  postInstall = ''
    cp -r languages $out/languages
  '';

  meta = {
    description = "breadcrumb plugin for Helix editor";
    homepage = "https://github.com/Ra77a3l3-jar/scopeline";
    license = lib.licenses.unfree;
    # maintainers = with lib.maintainers; [ ];
  };
})
