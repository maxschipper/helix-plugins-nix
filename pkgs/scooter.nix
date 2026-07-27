{
  buildHelixPluginWithNative,
  fetchFromGitHub,
  lib,
}:
buildHelixPluginWithNative (finalAttrs: {
  pname = "scooter.hx";
  version = "0.2.0";
  pluginName = "scooter";

  src = fetchFromGitHub {
    owner = "thomasschafer";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-07lBoELFYKZsREhGl8pPPD2bsBDpo1C3+T1M01jTM7E=";
  };

  cargoHash = "sha256-WqZHNQtLmu4hSmxfFQF3DwbtlL4hBe08BNmZbMsIQ0A=";

  doCheck = false;

  meta = {
    description = "Interactive find-and-replace Helix plugin";
    homepage = "https://github.com/thomasschafer/scooter.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
