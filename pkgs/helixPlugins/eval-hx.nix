{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  repl-ui-hx,
}:
buildHelixPlugin (finalAttrs: {
  pname = "eval.hx";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-ulSVRhW81GY83ZwHFzU6nLj/v0QAcw36rvJatKlbpXU=";
  };

  passthru.pluginDependencies = [ repl-ui-hx ];

  meta = {
    description = "Helix REPL scratch buffer for eval-string output";
    homepage = "https://github.com/waddie/eval.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
