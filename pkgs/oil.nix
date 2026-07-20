{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
  notify,
}:
buildHelixPlugin {
  pname = "oil";
  version = "0-unstable-2026-07-20";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "oil.hx";
    rev = "5e8fc997d862902b162eb96fb7914ae6ea02ae2b";
    hash = "sha256-IzTS2JNRLt7YGBecT8SVAIdCUf6ohvYFQfXQKiQoa90=";
  };

  pluginDependencies = [ notify ];

  meta = {
    description = "File Manager in a buffer for Helix editor";
    homepage = "https://github.com/Ra77a3l3-jar/oil.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
