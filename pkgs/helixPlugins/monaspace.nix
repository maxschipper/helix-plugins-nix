{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "monaspace.hx";
  version = "0-unstable-2026-08-25";

  src = fetchFromGitHub {
    owner = "Xerxes-2";
    repo = finalAttrs.pname;
    rev = "85b2efc375493fe4cc7d35b41f5c1da8866a56bd";
    hash = "sha256-dXG8N1Ilm1SFBerav7ieOfb3+NKnKZoqUSPovAqY/IE=";
  };

  passthru = {
    cogName = "monaspace";
    updateVersion = "branch";
  };

  meta = {
    description = "Plugin that enables Monaspace font mixing";
    homepage = "https://github.com/Xerxes-2/monaspace.hx";
    license = lib.licenses.unfree;
    # maintainers = with lib.maintainers; [ ];
  };
})
