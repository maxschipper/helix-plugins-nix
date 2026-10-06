{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  glyph-hx,
  notify-hx,
}:
buildHelixPlugin (finalAttrs: {
  pname = "forest.hx";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = finalAttrs.pname;
    tag = finalAttrs.version;
    hash = "sha256-/+opHMn5bggcTbzDvqZ4jNJxZwHXNjpv9e2sEmcLIgY=";
  };

  passthru = {
    cogName = "forest";
    pluginDependencies = [
      glyph-hx
      notify-hx
    ];
  };

  meta = {
    description = "A file explorer tree for Helix";
    homepage = "https://github.com/Ra77a3l3-jar/forest.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
