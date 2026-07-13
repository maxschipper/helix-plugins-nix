{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "who";
  version = "0-unstable-2026-07-08";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "who.hx";
    rev = "c0eb631b4b1b2239f5d83940b949558e4060e3c3";
    hash = "sha256-G5pec8cXzGGgkwNPPRggn4wGSayFbx6wN8+9hJKptqY=";
  };

  meta = {
    description = "who.hx shows inline git blame for Helix.";
    homepage = "https://github.com/Ra77a3l3-jar/who.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
