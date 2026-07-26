{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  ts-utils,
}:
buildHelixPlugin (finalAttrs: {
  pname = "ts-select.hx";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "ts-select.hx";
    tag = "v${finalAttrs.version}";
    hash = "sha256-TXyQgxgVlozTQBDKWB8UKAz+M3E9d3QO971Ew7SPABc=";
  };

  cogDependecies = [
    ts-utils
  ];

  meta = {
    description = "Create selections in Helix with an ad hoc tree-sitter query";
    homepage = "https://github.com/waddie/ts-select.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
