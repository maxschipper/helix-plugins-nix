{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  glyph,
  notify,
}:
buildHelixPlugin (finalAttrs: {
  pname = "forest.hx";
  version = "0.1.1-unstable-2026-08-23";
  cogName = "forest";
  updateVersion = "branch";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = finalAttrs.pname;
    rev = "07d74a1f38cbc88e4249869fa4740e568f988e9f";
    hash = "sha256-MWyZHv01vC8w3YF3LMNb8r+NiN8a1JLSUPIlyPwuuVI=";
  };

  pluginDependencies = [
    glyph
    notify
  ];

  meta = {
    description = "A file explorer tree for Helix";
    homepage = "https://github.com/Ra77a3l3-jar/forest.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
