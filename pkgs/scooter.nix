{
  buildHelixPluginWithNative,
  fetchFromGitHub,
  lib,
}:
buildHelixPluginWithNative (finalAttrs: {
  pname = "scooter.hx";
  version = "0.1.4-unstable-2026-07-11";
  pluginName = "scooter";

  src = fetchFromGitHub {
    owner = "thomasschafer";
    repo = finalAttrs.pname;
    rev = "6f35b3f714d0414dff34b2784017ddbe5d143cc1";
    hash = "sha256-N3EsZD4IbqlrrxlRDy4CcIz61yJu8Lv1P24Zxxva7pw=";
  };

  cargoHash = "sha256-wBQnWYdzRe6xsZZrFDHQoWBy535eQKoje+USopHTa00=";

  doCheck = false;

  meta = {
    description = "Interactive find-and-replace Helix plugin";
    homepage = "https://github.com/thomasschafer/scooter.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
