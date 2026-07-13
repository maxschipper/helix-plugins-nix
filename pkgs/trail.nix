{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "trail";
  version = "0-unstable-2026-07-07";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "trail.hx";
    rev = "9e6ebd8d57836c21a871eb25be40e8266d468035";
    hash = "sha256-uhCA7k5ntEDY656hwTGJXpKP/RmNQDsFkUsARQXd5rw=";
  };

  meta = {
    description = "recent project picker for Helix";
    homepage = "https://github.com/Ra77a3l3-jar/trail.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
