{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  ts-utils,
}:
buildHelixPlugin (finalAttrs: {
  pname = "ts-select.hx";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-CswQkhXtXhNvoKtmI8tKrQeMfiUzylBDuiAX2bmKvM4=";
  };

  dependencies = [
    ts-utils
  ];

  meta = {
    description = "Create selections in Helix with an ad hoc tree-sitter query";
    homepage = "https://github.com/waddie/ts-select.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
