{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "juju";
  version = "0.3.1-alpha-unstable-2026-07-03";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "juju";
    rev = "8e8a67d49d69e647ad256e08b75fddcba2f82264";
    hash = "sha256-i4RVPBwkBYkC8mTSM3QB5gXkKGsdgtXw1ruX+fAlR8I=";
  };

  meta = {
    description = "Juju is a git/jj interface for the Helix editor";
    homepage = "https://github.com/waddie/juju";
    license = lib.licenses.agpl3Only;
    # maintainers = with lib.maintainers; [ ];
  };

}
