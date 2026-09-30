{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  notify,
}:
buildHelixPlugin (finalAttrs: {
  pname = "oil.hx";
  version = "0-unstable-2026-09-30";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = finalAttrs.pname;
    rev = "5293af9033bc7de95334f9d5a399c149a7eadd75";
    hash = "sha256-pSfB9Gexqz+OaXYniN7JEtjb6LIo5GcM3reuCmXl93k=";
  };

  passthru = {
    cogName = "oil";
    updateVersion = "branch";
    pluginDependencies = [ notify ];
  };

  meta = {
    description = "File Manager in a buffer for Helix editor";
    homepage = "https://github.com/Ra77a3l3-jar/oil.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
