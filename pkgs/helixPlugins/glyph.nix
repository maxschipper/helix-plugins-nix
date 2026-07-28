{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "glyph.hx";
  version = "0.1.0";
  pluginName = "glyph";

  src = fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-PnJcPwdqa4PS6oWE4S7wB7go89UwfAaJxewFOm23Eno=";
  };

  meta = {
    description = "shared icon library for Helix plugins";
    homepage = "https://github.com/Ra77a3l3-jar/glyph.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
