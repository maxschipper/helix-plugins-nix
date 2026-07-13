{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "hxwiki";
  version = "0-unstable-2026-07-09";

  src = fetchFromGitHub {
    owner = "sipmann";
    repo = "hxwiki";
    rev = "424c4fc0ebb6abe6888a46c6c67a84390e0d8cd9";
    hash = "sha256-cm/0uLJYInn7IeSXgv9Qg3qKmX25x8spLRZt+tOX3iI=";
  };

  meta = {
    description = "A VimWiki-inspired wiki plugin for the Helix editor, built with Steel scripting — follow/create [[links]] and keep a daily diary without leaving the editor.";
    homepage = "https://github.com/sipmann/hxwiki";
    license = lib.licenses.agpl3Plus;
    # maintainers = with lib.maintainers; [ ];
  };
}
