{
  buildHelixPlugin,
  fetchFromCodeberg,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "context.hx";
  version = "0-unstable-2026-10-07";

  src = fetchFromCodeberg {
    owner = "gwid";
    repo = finalAttrs.pname;
    rev = "186a7f2062d45eba901f87e7151d0e4eece0603f";
    hash = "sha256-7okPQ4u/XYTLBdZKpHLSIqpNCboyrf5SmDlCXZUc8vM=";
  };

  postInstall = ''
    cp -r queries $out/queries
  '';

  passthru = {
    cogName = "context";
    updateVersion = "branch";
  };

  meta = {
    description = "treesitter breadcrumbs with proper context queries";
    homepage = "https://codeberg.org/gwid/context.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
