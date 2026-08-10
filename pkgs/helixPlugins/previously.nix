{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  ui-utils,
}:
buildHelixPlugin (finalAttrs: {
  pname = "previously.hx";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-xiA/ma7Op849FAuL/K8ePb7DK2xa9mLL1nU7hR0gjNw=";
  };

  pluginDependencies = [
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
