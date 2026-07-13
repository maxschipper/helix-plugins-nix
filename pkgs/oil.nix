{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
  notify,
}:
buildHelixPlugin {
  pname = "oil";
  version = "0-unstable-2026-07-06";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "oil.hx";
    rev = "da3af8e6bb405134818e35ea542d2ac90839c0bd";
    hash = "sha256-Tu+Xn1uWQk4N4NjsJ9fEqWupEHMp4qhpiM8JkxvcNuo=";
  };

  pluginDependencies = [ notify ];

  meta = {
    description = "File Manager in a buffer for Helix editor";
    homepage = "https://github.com/Ra77a3l3-jar/oil.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
