{
  buildHelixPlugin,
  fetchFromGitHub,
  glyph,
  lib,
  notify,
}:
buildHelixPlugin {
  pname = "forest";
  version = "0-unstable-2026-07-10";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "forest.hx";
    rev = "bc7fea7bbc70c285357e515af30678c26a100e7d";
    hash = "sha256-HP/ISHRNs6Se5im54QeT17mO5cs2jD3D5TvBrwJP55k=";
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
}
