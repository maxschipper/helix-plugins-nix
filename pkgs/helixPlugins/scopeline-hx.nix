{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  glyph,
}:
buildHelixPlugin (finalAttrs: {
  pname = "scopeline.hx";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = finalAttrs.pname;
    tag = finalAttrs.version;
    hash = "sha256-ZX1y7FPBCAGCULWxHdjF5mupGg/bx7KwTNAhqYwIvUQ=";
  };

  postInstall = ''
    cp -r languages $out/languages
  '';

  passthru = {
    cogName = "scopeline";
    pluginDependencies = [ glyph ];
  };

  meta = {
    description = "breadcrumb plugin for Helix editor";
    homepage = "https://github.com/Ra77a3l3-jar/scopeline.hx";
    license = lib.licenses.mit;
  };
})
