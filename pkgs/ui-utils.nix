{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "ui-utils.hx";
  version = "0.2.0-unstable-2026-07-22";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "ui-utils.hx";
    rev = "3262e80706f9d332b83d3ac0f578ffd40e2e0673";
    hash = "sha256-ur4qbWalj7yfLD05u8k4BRilpT47A4Jh264N6ewjhvk=";
  };

  meta = {
    description = "Shared UI functions for my Helix plug-ins";
    homepage = "https://github.com/waddie/ui-utils.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
