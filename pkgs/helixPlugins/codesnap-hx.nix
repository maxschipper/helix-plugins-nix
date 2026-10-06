# you also need to add pkgs.silicon to your environment.systemPackages
{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,

  ui-utils,
}:
buildHelixPlugin (finalAttrs: {
  pname = "codesnap.hx";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "Vyrnexis";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-9KB4ReGnGlStFijg+JLJEUgE+591uI/QC2M2CeMJuEA=";
  };

  doSteelCheck = true;

  passthru = {
    cogName = "codesnap";
    pluginDependencies = [ ui-utils ];
  };

  meta = {
    description = "Generate code snippets from your Helix visual selections. Powered by Silicon and the Steel plugin system.";
    homepage = "https://github.com/Vyrnexis/codesnap.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
