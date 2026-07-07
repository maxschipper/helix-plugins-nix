{
  fetchFromGitHub,
  lib,
  buildHelixPlugin,
}:
buildHelixPlugin {
  pname = "oil";
  version = "0-unstable-2026-07-02";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "oil.hx";
    rev = "913a3d3003ff82a8e8b1ab74b96949752cf081b8";
    hash = "sha256-/KJuXQctnVPmv9T9AR51RB6fRNQYg7XxyWAeekAQLGw=";
  };

  meta = {
    description = "File Manager in a buffer for Helix editor";
    homepage = "https://github.com/Ra77a3l3-jar/oil.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
