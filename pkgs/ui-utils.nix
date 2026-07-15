{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "ui-utils.hx";
  version = "0.1.4-unstable-2026-07-15";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "ui-utils.hx";
    rev = "d8daf89327b7e0431ec0ce66150aac6eda48b026";
    hash = "sha256-J0YYX2cfZKowtLTbYEFUevlPakyNAbpm2DDzA+cAbGo=";
  };

  meta = {
    description = "Shared UI functions for my Helix plug-ins";
    homepage = "https://github.com/waddie/ui-utils.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
