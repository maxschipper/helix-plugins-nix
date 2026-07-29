{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  ui-utils,
}:
buildHelixPlugin (finalAttrs: {
  pname = "previously.hx";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-w+2nAAZyoMFFKOuPTQuJQROpRyksstjjVen6RyC6tWc=";
  };

  dependencies = [
    ui-utils
  ];

  # [todo] tests

  meta = {
    description = "Helix register history for yanks, commands and searches";
    homepage = "https://github.com/waddie/previously.hx";
    license = lib.licenses.agpl3Only;
    # maintainers = with lib.maintainers; [ ];
  };
})
