{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  glyph,
}:
buildHelixPlugin (finalAttrs: {
  pname = "scopeline";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
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
    license = lib.licenses.mit;
  };
})
