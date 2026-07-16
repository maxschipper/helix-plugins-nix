{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
  run-command,
  ui-utils,
}:
buildHelixPlugin {
  pname = "juju";
  version = "0.3.9-alpha-unstable-2026-07-16";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "juju";
    rev = "fffa663793d8dbfd84715c67c236f56213fdd703";
    hash = "sha256-/WO0JPUqa+Vs2iwSAlpiVUR3jNGB/jSC0ADm/t3p+WY=";
  };

  pluginDependencies = [
    run-command
    ui-utils
  ];

  meta = {
    description = "Juju is a git/jj interface for the Helix editor";
    homepage = "https://github.com/waddie/juju";
    license = lib.licenses.agpl3Only;
    # maintainers = with lib.maintainers; [ ];
  };
}
