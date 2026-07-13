{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
  run-command,
  ui-utils,
}:
buildHelixPlugin {
  pname = "juju";
  version = "0.3.7-alpha-unstable-2026-07-11";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "juju";
    rev = "ca6ee130f2f2fdd25063f5d813131f9b8a88f0a6";
    hash = "sha256-SUXi5jIl7Oy6IQalWg6OPa9RdjrTooRbe6kPqxp4s4Y=";
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
