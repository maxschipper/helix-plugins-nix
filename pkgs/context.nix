{
  buildHelixPlugin,
  fetchFromCodeberg,
  lib,

  breadcrumbs,
}:
buildHelixPlugin (finalAttrs: {
  pname = "context.hx";
  version = "0-unstable-2026-07-23";
  pluginName = "context";

  src = fetchFromCodeberg {
    owner = "gwid";
    repo = finalAttrs.pname;
    rev = "90ec83415ddd2233007dfdb699f5c6f4d548416e";
    hash = "sha256-NnBNGQnkx+7iINbgUm7DIQPsiecHOCSEWKQa/EAtxiY=";
  };

  dependencies = [
    breadcrumbs
  ];

  meta = {
    description = "treesitter breadcrumbs with proper context queries";
    homepage = "https://codeberg.org/gwid/context.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
