{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: rec {
  pname = "boolswitcher.hx";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "noggynoggy";
    repo = "boolswitcher-hx";
    rev = "v${version}";
    hash = "sha256-XFnQBLe7Gqgc11px3y47sJGW1jVEKx8WcmVEbPHgkdU=";
  };

  passthru.cogName = "boolswitcher.hx";

  meta = {
    description = "boolswitcher-hx defines commands to switch/set booleans like True/False, yes/no, 1/0, etc.";
    homepage = "https://github.com/noggynoggy/boolswitcher-hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
