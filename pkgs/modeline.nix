{
  buildHelixPlugin,
  fetchFromCodeberg,
  lib,
}:
buildHelixPlugin {
  pname = "modeline";
  version = "0-unstable-2026-01-17";

  src = fetchFromCodeberg {
    owner = "gwid";
    repo = "modeline.hx";
    rev = "71ced41de61af7fded1869c44b843499e1385340";
    hash = "sha256-9ZpGPXDe0Q/LmGq9WXRVVW5IOoe95obq/fG6TWige60=";
  };

  meta = {
    description = "Helix Plugin for modeline";
    homepage = "https://codeberg.org/gwid/modeline.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
