{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "moka";
  version = "0-unstable-2026-07-21";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "moka.hx";
    rev = "0547d9aa4e80ac412fc530593121dd78769f36d2";
    hash = "sha256-/fgmoPTPg/TS6l3m5YlS8RrDlqycGXqJqLvB8H88kC8=";
  };

  meta = {
    description = "A fully configurable statusline and bufferline for Helix.";
    homepage = "https://github.com/Ra77a3l3-jar/moka.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
