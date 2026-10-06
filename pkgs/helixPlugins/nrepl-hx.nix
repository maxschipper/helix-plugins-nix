{
  buildHelixPluginWithNative,
  fetchFromGitHub,
  lib,

  repl-ui-hx,
  run-command-scm,
  ui-utils-hx,
}:
buildHelixPluginWithNative (finalAttrs: {
  pname = "nrepl.hx";
  version = "0.6.4";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-t8NWaRZiE1G5xrTfXX47dkbKlWJYQFt9VMLXFBe2BU8=";
  };

  cargoHash = "sha256-qBSu2t2Ji35Jy/VhBNGFQwbint94MnQkY6jFDVtb7Sc=";

  doSteelCheck = true;

  passthru.pluginDependencies = [
    repl-ui-hx
    run-command-scm
    ui-utils-hx
  ];

  meta = {
    description = "An nREPL client plugin for the Helix editor";
    homepage = "https://github.com/waddie/nrepl.hx";
    license = lib.licenses.agpl3Plus;
    # maintainers = with lib.maintainers; [ ];
  };
})
