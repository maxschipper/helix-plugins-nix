# not working on linux as is (error: env-var USERPROFILE isn't defined)
{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "hxwiki";
  version = "0-unstable-2026-09-21";

  src = fetchFromGitHub {
    owner = "sipmann";
    repo = finalAttrs.pname;
    rev = "3fc77f91a2e5c4f0aa52b6e4a5804e3f3a2467fd";
    hash = "sha256-JdiU0y8wxl1d1+fgpq54OyXsQvkSw9mZ0uy86tBh0/s=";
  };

  passthru.updateVersion = "branch";

  meta = {
    description = "A VimWiki-inspired wiki plugin for the Helix editor, built with Steel scripting — follow/create [[links]] and keep a daily diary without leaving the editor.";
    homepage = "https://github.com/sipmann/hxwiki";
    license = lib.licenses.agpl3Plus;
    # maintainers = with lib.maintainers; [ ];
  };
})
