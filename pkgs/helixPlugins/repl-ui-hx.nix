{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "repl-ui.hx";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-JqVUONP/6OKL/ZHuISBYQ8BsJ30dwVZSISucJj8Ul2I=";
  };

  meta = {
    description = "Shared library for REPL-style plugins.";
    homepage = "https://github.com/waddie/repl-ui.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
