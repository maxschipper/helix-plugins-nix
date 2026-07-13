{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "ui-utils.hx";
  version = "0.1.2-unstable-2026-07-11";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "ui-utils.hx";
    rev = "1e39594e1b36b82c2cf4f4d46733755449bba7bf";
    hash = "sha256-cNuXxHVINgOOdQH6yeNPva9ANuaq7j+OWG7SVmBW8M8=";
  };

  meta = {
    description = "Shared UI functions for my Helix plug-ins";
    homepage = "https://github.com/waddie/ui-utils.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
