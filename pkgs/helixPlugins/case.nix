{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "case.hx";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "apothecary103";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-S4zywk01tRohXJqiACFFkSZQXREglz2U3uMDKQ9Fjlg=";
  };

  meta = {
    description = "Change the case of selections in Helix";
    homepage = "https://github.com/apothecary103/case.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
