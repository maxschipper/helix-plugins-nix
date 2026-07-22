{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "run-command";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "run-command.scm";
    tag = "v${finalAttrs.version}";
    hash = "sha256-S6K9/3RB2SJu7eH3UlgPQ37YAF+WQLbvMYVuG7E4q+I=";
  };

  meta = {
    description = "Run a shell command in Steel Scheme, capturing stdout/stderr, with timeout";
    homepage = "https://github.com/waddie/run-command.scm";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
