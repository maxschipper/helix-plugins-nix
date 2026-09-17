{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "fresco.hx";
  version = "0-unstable-2026-07-27";
  cogName = "fresco";
  updateVersion = "branch";

  src = fetchFromGitHub {
    owner = "ivoronin";
    repo = finalAttrs.pname;
    rev = "6e4fe2dfc67c1aa3be396d973a35bcf8e6ebfad1";
    hash = "sha256-nb43TflqncOijOlBKcvcBo1RoJUM7Ii4okcUsNvhZw0=";
  };

  meta = {
    description = "Steel plugin that automatically reloads clean Helix documents changed on disk";
    homepage = "https://github.com/ivoronin/fresco.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
