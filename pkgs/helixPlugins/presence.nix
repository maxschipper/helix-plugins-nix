{
  buildHelixPluginWithNative,
  fetchFromCodeberg,
  lib,
}:
buildHelixPluginWithNative (finalAttrs: {
  pname = "presence.hx";
  version = "0-unstable-2026-08-26";
  cogName = "helix-discord-rpc";
  updateVersion = "branch";

  src = fetchFromCodeberg {
    owner = "paige";
    repo = finalAttrs.pname;
    rev = "ae7268372898e33d418fc613de5d473964e40f8c";
    hash = "sha256-L03AaAVzVLDndH7VSXP+6AaZJdU+4YoVloTpygfYw+o=";
  };

  cargoHash = "sha256-PEgm8O3YCpHuQLzEhR1FimJNvC4WBWw2K92ZTQ4qS7M=";

  meta = {
    description = "discord rich presence for helix";
    homepage = "https://codeberg.org/paige/presence.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
