{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  glyph,
  notify,
}:
buildHelixPlugin {
  pname = "forest.hx";
  version = "0-unstable-2026-07-13";
  pluginName = "forest";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "forest.hx";
    rev = "76f539932e78f3f7c6627379c9ca46dc8482128f";
    hash = "sha256-kQox4neRkJg5te6bbozur3/TW4m7u3VrPrZI3jE985k=";
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
}
