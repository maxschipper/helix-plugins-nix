{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
  run-command,
  ui-utils,
}:
buildHelixPlugin {
  pname = "juju";
  version = "0.3.9-alpha-unstable-2026-07-15";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "juju";
    rev = "a652ba5953109a668cf3283d861f21c4c7eea6d9";
    hash = "sha256-Ss5g/j3xuUrtiQ9vpVglAuTgLRiVnahVWcm+EGPZMIE=";
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
