{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "run-command";
  version = "0.3.0-unstable-2026-07-05";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "run-command.scm";
    rev = "ed42a376c4761e10530981c34797e7dde8e5abef";
    hash = "sha256-S6K9/3RB2SJu7eH3UlgPQ37YAF+WQLbvMYVuG7E4q+I=";
  };

  meta = {
    description = "Run a shell command in Steel Scheme, capturing stdout/stderr, with timeout";
    homepage = "https://github.com/waddie/run-command.scm";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
