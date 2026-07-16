{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "ui-utils.hx";
  version = "0.1.4-unstable-2026-07-16";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "ui-utils.hx";
    rev = "e014db8c179f88028c9eda622aad36b32dc2b253";
    hash = "sha256-Hg7JG4td9PWBOQ2TxlNyo8bQM5BMkmqvvx49916eI8w=";
  };

  meta = {
    description = "Shared UI functions for my Helix plug-ins";
    homepage = "https://github.com/waddie/ui-utils.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
