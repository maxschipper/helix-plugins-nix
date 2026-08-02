{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  glyph,
  notify,
}:
buildHelixPlugin (finalAttrs: {
  pname = "forest.hx";
  version = "0-unstable-2026-08-02";
  cogName = "forest";
  updateVersion = "branch";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = finalAttrs.pname;
    rev = "d6cc252930d7532c2f69710a18e47e61c02cf86b";
    hash = "sha256-O8rs83uvXfMQrb92C+DmI9euK8VLHYLo4meFN539R2s=";
  };

  dependencies = [
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
