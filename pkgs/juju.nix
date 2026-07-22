{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
  run-command,
  ui-utils,
}:
buildHelixPlugin {
  pname = "juju";
  version = "0.3.10-alpha-unstable-2026-07-22";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "juju";
    rev = "286044d763e637bbe2658caa4c663be9ca768b50";
    hash = "sha256-y7V+CgazFnwndNqESbrNwhuqJjXBKokH/bmg6bpFkP0=";
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
