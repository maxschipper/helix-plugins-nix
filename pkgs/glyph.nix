{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "glyph";
  version = "0-unstable-2026-07-08";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "glyph.hx";
    rev = "12972747ac56ed60dc721b870367180875120308";
    hash = "sha256-oAdU9nRKRMkxORE2C3rrzuT5B2c0eIttfFGf/2e57s4=";
  };

  meta = {
    description = "shared icon library for Helix plugins";
    homepage = "https://github.com/Ra77a3l3-jar/glyph.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
