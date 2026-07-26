{
  buildHelixPlugin,
  fetchFromCodeberg,
  lib,
}:
buildHelixPlugin {
  pname = "context";
  version = "0-unstable-2026-07-23";

  src = fetchFromCodeberg {
    owner = "gwid";
    repo = "context.hx";
    rev = "90ec83415ddd2233007dfdb699f5c6f4d548416e";
    hash = "sha256-NnBNGQnkx+7iINbgUm7DIQPsiecHOCSEWKQa/EAtxiY=";
  };

  meta = {
    description = "treesitter breadcrumbs with proper context queries";
    homepage = "https://codeberg.org/gwid/context.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
