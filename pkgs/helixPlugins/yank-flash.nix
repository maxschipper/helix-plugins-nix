{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "yank-flash.hx";
  version = "0-unstable-2026-08-06";
  cogName = "yank-flash";
  updateVersion = "branch";

  src = fetchFromGitHub {
    owner = "dmyyy";
    repo = finalAttrs.pname;
    rev = "93e1cb580293d1f6a4684839c06442100f36ed30";
    hash = "sha256-RVQFGiWW6mfxg5m4CSXDGArgnlAZehufQHie8UMVz98=";
  };

  meta = {
    description = "Visual feedback on yank.";
    homepage = "https://github.com/dmyyy/yank-flash.hx";
    license = lib.licenses.unfree;
    # maintainers = with lib.maintainers; [ ];
  };
})
