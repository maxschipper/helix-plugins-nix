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
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-X1YbnVgw50wM45SvMrFMmOrYnU1kEJbcBU09JvONQk8=";
  };

  cargoHash = "sha256-G3Rybk5e0ybiTCGw+P0Pd0oid4btQV1As9ze7q+XiL0=";

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
