{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "moka";
  version = "0-unstable-2026-07-14";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "moka.hx";
    rev = "d25ce9e302c3ef0cbad82ec6012582cbb66d440f";
    hash = "sha256-qV4MgOV3QJLQv8zCGvUSP5r8JOAWhx8jAUH+iKzHV9A=";
  };

  meta = {
    description = "A fully configurable statusline and bufferline for Helix.";
    homepage = "https://github.com/Ra77a3l3-jar/moka.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
