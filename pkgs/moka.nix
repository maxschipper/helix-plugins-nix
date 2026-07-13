{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "moka";
  version = "0-unstable-2026-07-13";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "moka.hx";
    rev = "05cd2728b515ef4001df0053faf076979225ca84";
    hash = "sha256-PUfU1HRN9+HbW8W5pluMKvSaAS6r7iPKgWecEsFufJ8=";
  };

  meta = {
    description = "A fully configurable statusline and bufferline for Helix.";
    homepage = "https://github.com/Ra77a3l3-jar/moka.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
