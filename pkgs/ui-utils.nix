{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "ui-utils.hx";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "ui-utils.hx";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ur4qbWalj7yfLD05u8k4BRilpT47A4Jh264N6ewjhvk=";
  };

  meta = {
    description = "Shared UI functions for my Helix plug-ins";
    homepage = "https://github.com/waddie/ui-utils.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
