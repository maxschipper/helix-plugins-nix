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
  version = "0.7.3";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-ug59QiqvvWEDXZnM+NGs5xZemYE2yAOP0Bi3tFl7D3U=";
  };

  cargoHash = "sha256-awMCUjuFe1/1n3zgTGHNPI8ZuGVX51QODRc4/DbBtyI=";

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
