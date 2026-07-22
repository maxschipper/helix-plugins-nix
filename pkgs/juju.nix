{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
  run-command,
  ui-utils,
}:
buildHelixPlugin (finalAttrs: {
  pname = "juju";
  version = "0.3.10-alpha";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "juju";
    tag = "v${finalAttrs.version}";
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
})
