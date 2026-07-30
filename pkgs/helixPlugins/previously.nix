{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  ui-utils,
}:
buildHelixPlugin (finalAttrs: {
  pname = "previously.hx";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-0qugl3c9sreW71s4L/ZndGf43xu+ajGycKwQs/TXzoQ=";
  };

  dependencies = [
    ui-utils
  ];

  doSteelCheck = true;

  meta = {
    description = "Helix register history for yanks, commands and searches";
    homepage = "https://github.com/waddie/previously.hx";
    license = lib.licenses.agpl3Only;
    # maintainers = with lib.maintainers; [ ];
  };
})
