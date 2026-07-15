{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "run-command";
  version = "0.3.0-unstable-2026-07-15";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "run-command.scm";
    rev = "cad0e1d5d9126e593f1ccdc031a70a766bf32be0";
    hash = "sha256-l9WEqHull3j+x61Fuvda3HyktN9AB5vZ+WOIjpC8tZc=";
  };

  meta = {
    description = "Run a shell command in Steel Scheme, capturing stdout/stderr, with timeout";
    homepage = "https://github.com/waddie/run-command.scm";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
